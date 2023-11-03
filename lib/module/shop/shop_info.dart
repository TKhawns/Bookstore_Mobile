// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable

import 'package:bookstore_mobile/module/shop/shop_bloc.dart';
import 'package:bookstore_mobile/repo/shop_repository/shop_repo.dart';
import 'package:bookstore_mobile/repo/shop_repository/shop_service.dart';
import 'package:flutter/material.dart';

import '../../repo/book_repository/book_data.dart';
import '../home/book_detail.dart';
import 'package:provider/provider.dart';

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
                height: 50,
                child: CircleAvatar(
                  radius: 35, // Image radius
                  backgroundImage:
                      AssetImage("assets/images/william_shakespear.jpg"),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          "Books Store",
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
                    padding: EdgeInsets.only(left: 5, bottom: 10),
                    child: Text(
                      "Ha Noi, Viet Nam",
                      style: TextStyle(color: Colors.grey[300], fontSize: 16),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {},
                    child: Text("+ Follow")),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
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
                          image: AssetImage("assets/images/bookadvertise1.jpg"),
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
                            image:
                                AssetImage("assets/images/bookadvertise3.jpg"),
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
                            image:
                                AssetImage("assets/images/bookadvertise4.jpg"),
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
                          image: AssetImage("assets/images/bookadvertise2.jpg"),
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
                childAspectRatio: (1 / 2),
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
        padding: EdgeInsets.only(bottom: 10),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Expanded(
            //   child:
            //       // Container(
            //       //   child: Hero(
            //       //     tag: '${bookData.title}',
            //       //     child: Image.asset(
            //       //       "assets/images/${bookData.image}",
            //       //       fit: BoxFit.fill,
            //       //     ),
            //       //   ),
            //       // ),
            // ),
            Image.asset(
              "assets/images/${bookData.image}",
              fit: BoxFit.fitWidth,
            ),
            Text(
              '${bookData.title}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
