// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:bookstore_mobile/widget/normalbutton.dart';
import 'package:flutter/material.dart';

class MyshopWidget extends StatefulWidget {
  const MyshopWidget({super.key});

  @override
  State<MyshopWidget> createState() => _MyshopWidgetState();
}

class _MyshopWidgetState extends State<MyshopWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Create Shop Information"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
              child: Text(
                "Step 1: Fill out Form",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 23),
              ),
            ),
            Container(
              height: 15,
              color: Colors.grey[200],
            ),
            Container(
              padding: EdgeInsets.only(left: 15),
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "Shop's Name",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  TextField(
                    cursorColor: Colors.black,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: "Enter text",
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 15,
              color: Colors.grey[200],
            ),
            Container(
              padding: EdgeInsets.only(left: 15),
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "Shop's Address",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  TextField(
                    cursorColor: Colors.black,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: "Enter text",
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 15,
              color: Colors.grey[200],
            ),
            Container(
              padding: EdgeInsets.only(left: 15),
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "Shop's PhoneNumber",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  TextField(
                    cursorColor: Colors.black,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: "Enter text",
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 200, left: 50, right: 50),
              child: NormalButton(
                title: "Confirm",
                onPressed: () {},
              ),
            ),
          ],
        ));
  }
}
