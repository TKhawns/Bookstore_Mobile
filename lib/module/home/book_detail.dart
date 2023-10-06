import 'package:bookstore_mobile/widget/book_list.dart';
import 'package:bookstore_mobile/widget/shop_info.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

import '../../repo/book_repository/book_data.dart';

class BookDetail extends StatelessWidget {
  final Book book;

  BookDetail({required this.book});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "About this book",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 151, 178),
        actions: [
          Container(
              margin: EdgeInsets.only(top: 15, right: 30),
              child: badges.Badge(
                badgeContent: Text(
                  '1',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Icon(
                  Icons.shopping_cart,
                  size: 30,
                ),
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.5,
              width: size.width,
              child: FittedBox(
                child: Image.asset(book.image),
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
                height: 70,
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
                            padding: EdgeInsets.only(right: 100, left: 10),
                            child: Text(
                              book.cost,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 5),
                            height: 36,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                            ),
                            child: Text(
                              "Best Seller",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 21,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 200),
                        child: Text("Number of books: " + book.count.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            )),
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
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: Text(
                        book.title,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
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
                              book.score,
                              style:
                                  TextStyle(fontSize: 22, color: Colors.black),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 70),
                            child: Text(
                              "Sold Books: 40",
                              style:
                                  TextStyle(fontSize: 22, color: Colors.black),
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
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 170),
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
                    "  Ship cost: " + book.shipCost,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 70),
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
                    backgroundImage: AssetImage(book.image),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Books Store",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      onPressed: () => {},
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(40, 40),
                          backgroundColor:
                              const Color.fromARGB(255, 0, 151, 178),
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(2.0))),
                      child: Text(
                        "Visit Shop",
                        style: TextStyle(fontSize: 18, color: Colors.white),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      book.description,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
