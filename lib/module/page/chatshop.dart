// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ChatShopPage extends StatefulWidget {
  const ChatShopPage({super.key});

  @override
  State<ChatShopPage> createState() => _ChatShopPageState();
}

class _ChatShopPageState extends State<ChatShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    "Thuong tra loi ngay",
                    style: TextStyle(color: Colors.grey[300], fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.more_horiz_outlined,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.grey[200],
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: 30, right: 20),
              child: Icon(
                Icons.add_circle_outline,
                color: Colors.black,
                size: 35,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(right: 30, top: 15, bottom: 15),
                child: TextField(
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 10, left: 20),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 10, color: Colors.black),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Enter Text",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
