// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, depend_on_referenced_packages, use_key_in_widget_constructors, must_be_immutable, sized_box_for_whitespace, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, unnecessary_cast, avoid_print

import 'dart:ui';

import 'package:bookstore_mobile/base/base_event.dart';
import 'package:bookstore_mobile/event/add_to_cart_event.dart';
import 'package:bookstore_mobile/event/fail_add_to_cart_event.dart';
import 'package:bookstore_mobile/event/success_add_to_cart_event.dart';
import 'package:bookstore_mobile/repo/author_repository/author_repo.dart';
import 'package:bookstore_mobile/repo/author_repository/author_service.dart';
import 'package:bookstore_mobile/repo/book_repository/book_data.dart';
import 'package:bookstore_mobile/repo/order_repository/order_repo.dart';
import 'package:bookstore_mobile/repo/order_repository/order_service.dart';
import 'package:bookstore_mobile/widget/bloc_listener.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

import '../../repo/book_repository/book_repo.dart';
import '../../repo/book_repository/book_service.dart';
import '../../repo/user_repository/user_repo.dart';
import '../../repo/user_repository/user_service.dart';
import '../../widget/shopping_cart.dart';
import '../home/book_detail.dart';
import '../home/home_bloc.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:google_fonts/google_fonts.dart';

class HotBook extends StatefulWidget {
  const HotBook({super.key});

  @override
  State<HotBook> createState() => _HotBookState();
}

class _HotBookState extends State<HotBook> {
  List<BookData> bookData = [];

  @override
  Widget build(BuildContext context) {
    final Object? customerId = ModalRoute.of(context)!.settings.arguments;
    return MultiProvider(
      providers: [
        Provider<HotBook>(
          create: (_) => HotBook(),
        ),
        Provider.value(
          value: UserService(),
        ),
        ProxyProvider<UserService, UserRepo>(
          update: (context, userService, previous) =>
              UserRepo(userService: userService),
        ),
        Provider.value(
          value: BookService(),
        ),
        ProxyProvider<BookService, BookRepo>(
          update: (context, bookService, previous) =>
              BookRepo(bookService: bookService),
        ),
        Provider.value(
          value: AuthorService(),
        ),
        ProxyProvider<AuthorService, AuthorRepo>(
          update: (context, authorService, previous) =>
              AuthorRepo(authorService: authorService),
        ),
        Provider.value(
          value: OrderService(),
        ),
        ProxyProvider<OrderService, OrderRepo>(
          update: (context, orderService, previous) =>
              OrderRepo(orderService: orderService),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Hot Books",
            style: GoogleFonts.inter(color: Colors.white, fontSize: 25),
          ),
          backgroundColor: const Color.fromARGB(255, 0, 151, 178),
          actions: [
            ShoppingCartWidget(
              customerId: customerId as String,
            ),
          ],
        ),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: BookListWidget(
            customerId: customerId as String,
          ),
        ),
      ),
    );
  }
}

class BookListWidget extends StatefulWidget {
  final String customerId;
  BookListWidget({required this.customerId});

  @override
  State<BookListWidget> createState() => _BookListWidgetState();
}

class _BookListWidgetState extends State<BookListWidget> {
  List<BookData> bookData = [];
  HomeBloc? bloc = HomeBloc.getInstance(
      bookRepo: BookRepo(bookService: BookService()),
      authorRepo: AuthorRepo(authorService: AuthorService()),
      orderRepo: OrderRepo(orderService: OrderService()),
      userRepo: UserRepo(userService: UserService()));

  handleEvent(BaseEvent event) {
    if (event is FailAddToCartEvent) {
      showAlertDialog(context, bloc!);
    }
    event = SuccessAddToCardEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<HomeBloc?>.value(
      value: HomeBloc.getInstance(
        bookRepo: Provider.of(context),
        authorRepo: Provider.of(context),
        orderRepo: Provider.of(context),
        userRepo: Provider.of(context),
      ),
      child: Consumer<HomeBloc>(builder: (context, bloc, child) {
        bloc.getBookList().listen((event) {
          for (var book in event) {
            bookData.add(book);
          }
        });
        return StreamProvider<List<BookData>?>.value(
          initialData: bookData,
          value: bloc.getBookList(),
          child: Consumer<List<BookData>?>(
            builder: (context, data, child) {
              if (data!.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.yellow,
                  ),
                );
              }

              return BlocListener<HomeBloc>(
                listener: handleEvent,
                child: ListView(
                  children:
                      newBuildBooks(bookData, context, bloc, widget.customerId),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  List<Widget> newBuildBooks(List<BookData> data, BuildContext context,
      HomeBloc bloc, String customerId) {
    List<Widget> list = [];
    for (var i = 0; i < data.length; i++) {
      list.add(newbuildBook(data[i], i, context, bloc, customerId));
    }
    return list;
  }

  Widget newbuildBook(BookData book, int index, BuildContext context,
      HomeBloc bloc, String customerId) {
    return Container(
      height: 180,
      child: Card(
        elevation: 3.0,
        child: Container(
          padding: EdgeInsets.only(left: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookDetail(
                              bookData: book,
                              customerId: customerId,
                            )),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/images/${book.image}",
                    width: 100,
                    height: 150,
                  ),
                ),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 15, left: 15, right: 10),
                    child: Text(
                      book.title,
                      style: GoogleFonts.inter(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, left: 15),
                    child: Text(
                      "${book.count} books",
                      style:
                          GoogleFonts.inter(color: Colors.blue, fontSize: 17),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, top: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 22,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 22,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 22,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 22,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.grey[300],
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5, left: 15),
                        child: Text(
                          '${MoneyFormatter(amount: double.parse(book.cost)).output.withoutFractionDigits} VND',
                          style: GoogleFonts.inter(
                              color: Colors.red,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        child: ElevatedButton(
                          onPressed: () {
                            bloc.event.add(AddToCartEvent(book, customerId));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 0, 151, 178),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                          ),
                          child: Text(
                            ' Buy now ',
                            style: GoogleFonts.inter(
                                color: Colors.white, fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  )),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, HomeBloc bloc) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "OK",
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          fontSize: 19,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        bloc.processEventSink.add(SuccessAddToCardEvent());
      },
    );

    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(26.0))),
      title: Text(
        "Oops",
        style: GoogleFonts.inter(
          color: Colors.red,
          fontWeight: FontWeight.w500,
          fontSize: 22,
        ),
      ),
      content: SizedBox(
        width: 320,
        child: Text(
          "Sách này đã có trong giỏ hàng!",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
      actions: [
        cancelButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class ShoppingCartWidget extends StatelessWidget {
  final String customerId;
  ShoppingCartWidget({required this.customerId});
  @override
  Widget build(BuildContext context) {
    return Provider<HomeBloc?>.value(
      value: HomeBloc.getInstance(
        bookRepo: Provider.of(context),
        orderRepo: Provider.of(context),
        authorRepo: Provider.of(context),
        userRepo: Provider.of(context),
      ),
      child: CartWidget(customerId: customerId),
    );
  }
}

class CartWidget extends StatefulWidget {
  final String customerId;
  CartWidget({required this.customerId});
  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var bloc = Provider.of<HomeBloc>(context);
    bloc.getShoppingCartInfo(widget.customerId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeBloc>(
      builder: (context, bloc, child) {
        return StreamProvider<ShoppingCart?>.value(
          initialData: null,
          value: bloc.shoppingCartStream,
          catchError: (context, error) {
            return ShoppingCart(total: -1);
          },
          child: Consumer<ShoppingCart?>(
            builder: (context, value, child) {
              if (value == null) {
                return Container(
                  margin: EdgeInsets.only(top: 15, right: 20),
                  child: Icon(Icons.shopping_cart),
                );
              }
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/checkout",
                      arguments: widget.customerId);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 15, right: 20),
                  child: badges.Badge(
                    badgeContent: Text(
                      "${value.total}",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Icon(Icons.shopping_cart),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
