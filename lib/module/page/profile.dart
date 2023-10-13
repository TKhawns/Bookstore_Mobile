// ignore_for_file: prefer_const_constructors

import 'package:bookstore_mobile/module/signin/signin_page.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My Account",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 151, 178),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 25, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Icon(
                      Icons.account_circle_rounded,
                      size: 70,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Trinh Khanh",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Text(
                        "trinhkhanhctdt@gmail.com",
                        style: TextStyle(color: Colors.red, fontSize: 19),
                      ),
                      Text(
                        "0382588919",
                        style: TextStyle(color: Colors.black, fontSize: 19),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Icon(
                      Icons.edit_note_rounded,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20, left: 20),
              child: Text(
                "Account",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[50],
                  minimumSize: Size(200, 80),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.feed,
                      size: 28,
                      color: Colors.black,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15, right: 140),
                      child: Text(
                        "Book Orders",
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 25,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),

            // DISCOUNT Row
            Container(
              padding: EdgeInsets.only(top: 15),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[50],
                  minimumSize: Size(200, 80),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.discount_rounded,
                      size: 28,
                      color: Colors.black,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15, right: 130),
                      child: Text(
                        "Your Vouchers",
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 25,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[50],
                  minimumSize: Size(200, 80),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.circle_notifications_rounded,
                      size: 28,
                      color: Colors.black,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 130),
                      child: Text(
                        "Notifications   ",
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 25,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                      ModalRoute.withName('/sign-in'));
                  return;
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[50],
                  minimumSize: Size(200, 80),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.settings_rounded,
                      size: 28,
                      color: Colors.black,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15, right: 100),
                      child: Text(
                        "Account Log out",
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 25,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20, left: 20),
              child: Text(
                "General Information",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[50],
                  minimumSize: Size(200, 80),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      size: 28,
                      color: Colors.black,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15, right: 130),
                      child: Text(
                        "App Reviews  ",
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 25,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
