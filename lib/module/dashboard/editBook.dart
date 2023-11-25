// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, depend_on_referenced_packages, use_key_in_widget_constructors, must_be_immutable, sized_box_for_whitespace, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, file_names

import 'dart:ui';

import 'package:bookstore_mobile/event/add_to_cart_event.dart';
import 'package:bookstore_mobile/repo/author_repository/author_repo.dart';
import 'package:bookstore_mobile/repo/author_repository/author_service.dart';
import 'package:bookstore_mobile/repo/book_repository/book_data.dart';
import 'package:bookstore_mobile/repo/order_repository/order_repo.dart';
import 'package:bookstore_mobile/repo/order_repository/order_service.dart';
import 'package:bookstore_mobile/repo/user_repository/user_repo.dart';
import 'package:bookstore_mobile/repo/user_repository/user_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../repo/book_repository/book_repo.dart';
import '../../repo/book_repository/book_service.dart';
import '../home/book_detail.dart';
import '../home/home_bloc.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:google_fonts/google_fonts.dart';

class EditBook extends StatefulWidget {
  final String shopName;
  const EditBook({required this.shopName});

  @override
  State<EditBook> createState() => _EditBookState();
}

class _EditBookState extends State<EditBook> {
  List<BookData> bookData = [];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<EditBook>(
          create: (_) => EditBook(
            shopName: "",
          ),
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
            "Your Books",
            style: GoogleFonts.inter(color: Colors.white, fontSize: 25),
          ),
          backgroundColor: const Color.fromARGB(255, 0, 151, 178),
        ),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: BookListWidget(
            shopName: "",
          ),
        ),
      ),
    );
  }
}

class BookListWidget extends StatelessWidget {
  List<BookData> bookData = [];
  final String shopName;
  BookListWidget({required this.shopName});

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
            if (book.shopName == "Book Store") {
              bookData.add(book);
            }
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

              return ListView(
                children: newBuildBooks(bookData, context, bloc),
              );
            },
          ),
        );
      }),
    );
  }

  List<Widget> newBuildBooks(
      List<BookData> data, BuildContext context, HomeBloc bloc) {
    List<Widget> list = [];
    for (var i = 0; i < data.length; i++) {
      list.add(newbuildBook(data[i], i, context, bloc));
    }
    return list;
  }

  Widget newbuildBook(
      BookData book, int index, BuildContext context, HomeBloc bloc) {
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
                              customerId: "",
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
                            bloc.event.add(
                              AddToCartEvent(
                                  book, "3af298e0-e126-4ce0-b957-b637869b2da3"),
                            );
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
                            ' Change ',
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
}
