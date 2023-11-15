// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, depend_on_referenced_packages

import 'package:bookstore_mobile/module/signin/signin_page.dart';
import 'package:bookstore_mobile/repo/user_repository/user_repo.dart';
import 'package:bookstore_mobile/repo/user_repository/user_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MyProfile>(
          create: (_) => MyProfile(),
        ),
        Provider.value(value: UserService()),
        ProxyProvider<UserService, UserRepo>(
          update: (context, userService, previous) =>
              UserRepo(userService: userService),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "My Account",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          backgroundColor: const Color.fromARGB(255, 0, 151, 178),
        ),
        body: ProfileWidget(),
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 25, left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.account_circle_rounded,
                  size: 70,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Trinh Khanh",
                        style: GoogleFonts.inter(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                    Text(
                      "",
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
                    padding: EdgeInsets.only(left: 15, right: 120),
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
                    padding: EdgeInsets.only(left: 15, right: 190),
                    child: Text(
                      "Log out",
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
    );
  }
}
