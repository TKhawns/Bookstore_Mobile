// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, sized_box_for_whitespace

import 'package:bookstore_mobile/module/dashboard/editBook.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'addbook.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Dash Board",
            style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
        actions: [
          Container(
            padding: EdgeInsets.only(
              right: 15,
              top: 5,
            ),
            child: Icon(
              Icons.message_rounded,
              size: 30,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 80,
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, top: 30, bottom: 15),
                  child: Row(
                    children: [
                      Text(
                        "Welcome,",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        " BookStore",
                        style: GoogleFonts.inter(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: Color.fromARGB(255, 0, 151, 178),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            height: 1,
            width: size.width,
            color: Colors.grey[300],
          ),
          Container(
              alignment: Alignment.center,
              width: size.width * 0.9,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Doanh thu",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "0 VND",
                          style: GoogleFonts.inter(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                            fontSize: 21,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 2,
                    color: Colors.grey[600],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Tổng đơn hàng",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "0",
                        style: GoogleFonts.inter(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                          fontSize: 21,
                        ),
                      ),
                    ],
                  ),
                ],
              )),
          Container(
            height: 1,
            width: size.width,
            color: Colors.grey[300],
          ),
          Container(
            padding: EdgeInsets.only(right: 60, top: 25),
            child: Text(
              "What do you want to do today ?",
              style:
                  GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 19),
            ),
          ),
          GridView.count(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 50,
            ),
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => AddBookPage())));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 8,
                        blurRadius: 12,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding:
                                EdgeInsets.only(top: 10, left: 10, right: 45),
                            child: Icon(
                              Icons.add_circle_rounded,
                              color: Colors.grey[500],
                              size: 60,
                            ),
                          ),
                          Icon(
                            Icons.arrow_circle_right_outlined,
                            size: 40,
                            color: Colors.grey[500],
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: 20,
                          left: 20,
                        ),
                        child: Text(
                          "Add a new book",
                          style: GoogleFonts.inter(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 21),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 8,
                        blurRadius: 12,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding:
                                EdgeInsets.only(top: 10, left: 10, right: 45),
                            child: Icon(
                              Icons.calendar_month_sharp,
                              color: Colors.grey[500],
                              size: 60,
                            ),
                          ),
                          Icon(
                            Icons.arrow_circle_right_outlined,
                            size: 40,
                            color: Colors.grey[500],
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: 20,
                          left: 20,
                        ),
                        child: Text(
                          "Orders",
                          style: GoogleFonts.inter(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 21),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditBook(
                                shopName: "Book Store",
                              )));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 8,
                        blurRadius: 12,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding:
                                EdgeInsets.only(top: 10, left: 10, right: 45),
                            child: Icon(
                              Icons.menu_book,
                              color: Colors.grey[500],
                              size: 60,
                            ),
                          ),
                          Icon(
                            Icons.arrow_circle_right_outlined,
                            size: 40,
                            color: Colors.grey[500],
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: 20,
                          left: 20,
                        ),
                        child: Text(
                          "Products",
                          style: GoogleFonts.inter(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 21),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                    20.0,
                  )),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey[200],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 8,
                          blurRadius: 12,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.only(top: 10, left: 10, right: 45),
                              child: Icon(
                                Icons.info_outline_rounded,
                                color: Colors.grey[500],
                                size: 60,
                              ),
                            ),
                            Icon(
                              Icons.arrow_circle_right_outlined,
                              size: 40,
                              color: Colors.grey[500],
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: 20,
                            left: 20,
                          ),
                          child: Text(
                            "More info",
                            style: GoogleFonts.inter(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 21),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
