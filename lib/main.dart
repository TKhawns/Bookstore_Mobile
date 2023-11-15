// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import 'package:bookstore_mobile/module/checkout/checkout.dart';
import 'package:bookstore_mobile/module/home/user_home_page.dart';
import 'package:bookstore_mobile/module/author/famous_author.dart';
import 'package:bookstore_mobile/module/book/hotbook.dart';
import 'package:bookstore_mobile/module/page/profile.dart';
import 'package:bookstore_mobile/module/search/search_view.dart';
import 'package:bookstore_mobile/module/shop/myshop.dart';
import 'package:bookstore_mobile/module/shop/showdialog.dart';
import 'package:bookstore_mobile/module/signin/signin_page.dart';
import 'package:bookstore_mobile/module/signup/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'module/home/shophomepage.dart';
import 'module/dashboard/dash_board.dart';
import 'dart:ui';

void main() {
  runApp(DevicePreview(enabled: true, builder: ((context) => MyApp())));
}
// void main() => runApp(MyApp());

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});
  static Map<int, Color> color = {
    50: Color.fromARGB(255, 0, 151, 178),
    100: Color.fromARGB(255, 0, 151, 178),
    200: Color.fromARGB(255, 0, 151, 178),
    300: Color.fromARGB(255, 0, 151, 178),
    400: Color.fromARGB(255, 0, 151, 178),
    500: Color.fromARGB(255, 0, 151, 178),
    600: Color.fromARGB(255, 0, 151, 178),
    700: Color.fromARGB(255, 0, 151, 178),
    800: Color.fromARGB(255, 0, 151, 178),
    900: Color.fromARGB(255, 0, 151, 178),
  };
  MaterialColor primeColor = MaterialColor(0xFF0097B2, color);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Store',
      theme: ThemeData(
        primarySwatch: primeColor,
      ),
      initialRoute: "/sign-in",
      routes: <String, WidgetBuilder>{
        "/": (context) => HotBook(),
        "/sign-up": (context) => SignUpPage(),
        "/sign-in": (context) => SignInPage(),
        "/home": (context) => HomePage(),
        "/hotbook": (context) => HotBook(),
        "/profile": (context) => MyProfile(),
        "/famous-author": (context) => FamousAuthor(),
        "/search_view": (context) => SearchView(),
        "/checkout": (context) => CheckoutWidget(),
        "/myshop": (context) => MyshopWidget(),
        "/showdialog": (context) => ShowDialogWidget(),
        "/newhome": (context) => NewHomePage(),
        "/dashboard": (context) => DashBoardPage(),
      },
      //home: SignInPage(),
    );
  }
}
