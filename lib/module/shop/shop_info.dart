// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors_in_immutables, depend_on_referenced_packages, avoid_print

import 'dart:ui';

import 'package:bookstore_mobile/module/shop/shop_bloc.dart';
import 'package:bookstore_mobile/repo/shop_repository/shop_repo.dart';
import 'package:bookstore_mobile/repo/shop_repository/shop_service.dart';
import 'package:flutter/material.dart';

import '../../repo/book_repository/book_data.dart';
import '../home/book_detail.dart';
import 'package:provider/provider.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopInfoWidget extends StatefulWidget {
  final String shopName;
  ShopInfoWidget({required this.shopName});

  @override
  State<ShopInfoWidget> createState() => _ShopInfoWidgetState();
}

class _ShopInfoWidgetState extends State<ShopInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ShopInfoWidget>(
          create: (_) => ShopInfoWidget(
            shopName: '',
          ),
        ),
        Provider.value(value: ShopService()),
        ProxyProvider<ShopService, ShopRepo>(
          update: (context, shopService, previous) =>
              ShopRepo(shopService: shopService),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Container(
                height: 45,
                child: CircleAvatar(
                  radius: 35, // Image radius
                  backgroundImage: AssetImage("assets/images/tugiac.jpg"),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            widget.shopName,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 3),
                          child: Icon(
                            Icons.verified_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5, left: 5, bottom: 10),
                      child: Text(
                        "Ha Noi, Viet Nam",
                        style: TextStyle(color: Colors.grey[400], fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {},
                    child: Text("+ Follow")),
              ),
            ],
          ),
        ),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: SingleChildScrollView(
            child: Container(
              color: Colors.grey[300],
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          image: DecorationImage(
                            image:
                                AssetImage("assets/images/bookadvertise1.jpg"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        margin: EdgeInsets.only(
                          top: 10,
                          left: 10,
                          right: 10,
                        ),
                        height: 140,
                        width: 240,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/bookadvertise3.jpg"),
                              fit: BoxFit.fill,
                            ),
                          ),
                          margin: EdgeInsets.only(top: 10, right: 10),
                          height: 140,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/bookadvertise4.jpg"),
                              fit: BoxFit.fill,
                            ),
                          ),
                          margin: EdgeInsets.only(top: 10, left: 10),
                          height: 140,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          image: DecorationImage(
                            image:
                                AssetImage("assets/images/bookadvertise2.jpg"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        margin: EdgeInsets.only(
                          top: 10,
                          left: 10,
                          right: 10,
                        ),
                        height: 140,
                        width: 240,
                      ),
                    ],
                  ),
                  Container(
                    height: 10,
                  ),
                  Container(
                    color: Colors.white,
                    alignment: Alignment.centerLeft,
                    height: 60,
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Bán Chạy Nhất",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 21),
                    ),
                  ),
                  Container(
                    height: 10,
                  ),
                  BookListWidget(shopName: widget.shopName),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BookListWidget extends StatelessWidget {
  final String shopName;
  BookListWidget({required this.shopName});
  List<BookData> bookData = [];

  @override
  Widget build(BuildContext context) {
    return Provider<ShopBloc?>.value(
      value: ShopBloc(shopRepo: Provider.of(context)),
      child: Consumer<ShopBloc>(builder: (context, bloc, child) {
        bloc.getBookDetail(shopName).listen((event) {
          for (var book in event) {
            bookData.add(book);
          }
        });
        return StreamProvider<List<BookData>?>.value(
          initialData: bookData,
          value: bloc.getBookDetail(shopName),
          catchError: (context, error) {
            print("loi");
          },
          child: Consumer<List<BookData>>(
            builder: (context, data, child) {
              if (data.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.yellow,
                  ),
                );
              }
              return GridView.count(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                childAspectRatio: (1 / 2.2),
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: newBuildBooks(data, context),
              );
            },
          ),
        );
      }),
    );
  }

  List<Widget> newBuildBooks(List<BookData> data, BuildContext context) {
    List<Widget> list = [];
    for (var i = 0; i < data.length; i++) {
      list.add(newbuildBook(data[i], i, context));
    }
    return list;
  }

  Widget newbuildBook(BookData bookData, int index, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BookDetail(bookData: bookData)),
        );
      },
      child: Container(
        height: 900,
        padding: EdgeInsets.only(bottom: 10),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              child: Image.asset(
                "assets/images/${bookData.image}",
                fit: BoxFit.fitHeight,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 15, left: 10),
                child: Text(
                  bookData.title,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                Text(
                  bookData.score.toString(),
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    "|  Da ban: 5k+",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                '${MoneyFormatter(amount: double.parse(bookData.cost)).output.withoutFractionDigits} VND',
                style: GoogleFonts.inter(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
