import 'package:bookstore_mobile/module/home/home_page.dart';
import 'package:bookstore_mobile/module/page/hotbook.dart';
import 'package:bookstore_mobile/module/page/profile.dart';
import 'package:bookstore_mobile/module/signin/signin_page.dart';
import 'package:bookstore_mobile/module/signup/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

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
      initialRoute: "/",
      routes: <String, WidgetBuilder>{
        "/": (context) => SignInPage(),
        "/sign-up": (context) => SignUpPage(),
        "/sign-in": (context) => SignInPage(),
        "/home": (context) => HomePage(),
        "/hotbook": (context) => HotBook(),
        "/profile": (context) => MyProfile(),
      },
      //home: SignInPage(),
    );
  }
}
