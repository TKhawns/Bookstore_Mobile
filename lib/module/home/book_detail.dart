// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, sized_box_for_whitespace, sort_child_properties_last, prefer_interpolation_to_compose_strings, library_private_types_in_public_api
import 'dart:ui';

import 'package:bookstore_mobile/module/page/chatshop.dart';
import 'package:bookstore_mobile/module/shop/shop_info.dart';
import 'package:bookstore_mobile/repo/book_repository/book_data.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:money_formatter/money_formatter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../repo/author_repository/author_repo.dart';
import '../../repo/author_repository/author_service.dart';
import '../../repo/book_repository/book_repo.dart';
import '../../repo/book_repository/book_service.dart';
import '../../repo/order_repository/order_repo.dart';
import '../../repo/order_repository/order_service.dart';
import '../../repo/user_repository/user_repo.dart';
import '../../repo/user_repository/user_service.dart';
import '../../widget/shopping_cart.dart';
import 'home_bloc.dart';

class BookDetail extends StatefulWidget {
  final BookData bookData;
  final String customerId;
  BookDetail({required this.bookData, required this.customerId});

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  Color myColor = Colors.white;
  Color myColorAdd = Colors.white;
  void _updateColor(PointerEvent details) {
    setState(() {
      myColor = Colors.grey.shade300;
    });
  }

  void _updateColorAdd(PointerEvent details) {
    setState(() {
      myColorAdd = Colors.grey.shade300;
    });
  }

  void _onExit(PointerEvent details) {
    setState(() {
      myColor = Colors.white;
    });
  }

  void _onExitAdd(PointerEvent details) {
    setState(() {
      myColorAdd = Colors.white;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MultiProvider(
      providers: [
        Provider<BookDetail>(
          create: (_) => BookDetail(
            bookData: BookData(
                book_id: 0,
                title: 'title',
                description: 'description',
                score: 'score',
                image: 'image',
                cost: 'cost',
                count: 1,
                shipCost: 'shipCost',
                authorName: 'authorName',
                shopName: 'shopName',
                shop_image: 'shop_image',
                quantity: 'quantity'),
            customerId: "",
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
            "About this book",
            style: GoogleFonts.inter(color: Colors.white, fontSize: 25),
          ),
          backgroundColor: const Color.fromARGB(255, 0, 151, 178),
          actions: [
            ShoppingCartWidget(),
          ],
        ),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: size.height * 0.5,
                  width: size.width,
                  child: FittedBox(
                    child:
                        Image.asset("assets/images/${widget.bookData.image}"),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  color: Colors.grey[300],
                  child: SizedBox(
                    height: 20,
                    width: size.width,
                  ),
                ),
                Container(
                  color: Color.fromARGB(255, 0, 151, 178),
                  child: SizedBox(
                    height: 75,
                    width: size.width,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(right: 90, left: 15),
                                child: Text(
                                  '${MoneyFormatter(amount: double.parse(widget.bookData.cost)).output.withoutFractionDigits} VND',
                                  style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 35,
                                width: 140,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                ),
                                child: Text(
                                  "Best Seller",
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              right: 230,
                            ),
                            child: Text(
                                "Kho Sách: " + widget.bookData.count.toString(),
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: SizedBox(
                    width: size.width,
                    height: 90,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 10, left: 15),
                          child: Text(
                            widget.bookData.title,
                            style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 20, left: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 22,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                size: 22,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                size: 22,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                size: 22,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                size: 22,
                                color: Colors.grey,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  widget.bookData.score,
                                  style: GoogleFonts.inter(
                                      fontSize: 22, color: Colors.black),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 100),
                                child: Text(
                                  "Đã bán: 1k+",
                                  style: GoogleFonts.inter(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey[300],
                  child: SizedBox(
                    width: size.width,
                    height: 15,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  padding: EdgeInsets.only(left: 15),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Voucher of Shop",
                        style: GoogleFonts.inter(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 165),
                        child: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey[300],
                  child: SizedBox(
                    width: size.width,
                    height: 15,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  padding: EdgeInsets.only(left: 15),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.delivery_dining_rounded,
                        size: 40,
                      ),
                      Text(
                        "  Ship cost: " + widget.bookData.shipCost,
                        style: GoogleFonts.inter(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 60),
                        child: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey[300],
                  child: SizedBox(
                    width: size.width,
                    height: 15,
                  ),
                ),
                Container(
                  height: 90,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 35, // Image radius
                        backgroundImage:
                            NetworkImage(widget.bookData.shop_image),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          widget.bookData.shopName,
                          style: GoogleFonts.inter(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 3),
                        child: Icon(
                          Icons.verified_rounded,
                          color: Colors.blue,
                          size: 20,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 30, right: 10),
                        child: ElevatedButton(
                          onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShopInfoWidget(
                                      shopName: widget.bookData.shopName),
                                ))
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(40, 40),
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 151, 178),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2.0))),
                          child: Text(
                            "Visit Shop",
                            style: GoogleFonts.inter(
                                fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey[300],
                  child: SizedBox(
                    width: size.width,
                    height: 15,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Text(
                        "Book Description",
                        style: GoogleFonts.inter(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          widget.bookData.description,
                          style: GoogleFonts.inter(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 8,
                blurRadius: 12,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            MouseRegion(
              onHover: _updateColor,
              onExit: _onExit,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatShopPage(
                              customerId: widget.customerId,
                              shopName: widget.bookData.shopName,
                              shopImage: widget.bookData.shop_image,
                            )),
                  );
                },
                child: Container(
                  color: myColor,
                  height: 60,
                  padding: EdgeInsets.only(left: 0, right: 45),
                  child: Container(
                    padding: EdgeInsets.only(left: 45),
                    child: Icon(
                      Icons.forward_to_inbox_rounded,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 30,
              color: Colors.black,
              width: 1,
            ),
            MouseRegion(
              onHover: _updateColorAdd,
              onExit: _onExitAdd,
              child: Container(
                height: 60,
                color: myColorAdd,
                child: Container(
                  padding: EdgeInsets.only(left: 45, right: 45),
                  child: Icon(
                    Icons.add_shopping_cart_outlined,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.red,
                child: Center(
                  child: Text(
                    "Buy now",
                    style: GoogleFonts.inter(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class ShoppingCartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<HomeBloc?>.value(
      value: HomeBloc.getInstance(
        bookRepo: Provider.of(context),
        orderRepo: Provider.of(context),
        authorRepo: Provider.of(context),
        userRepo: Provider.of(context),
      ),
      child: CartWidget(),
    );
  }
}

class CartWidget extends StatefulWidget {
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
    bloc.getShoppingCartInfo("3af298e0-e126-4ce0-b957-b637869b2da3");
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
                  Navigator.pushNamed(context, "/checkout");
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
