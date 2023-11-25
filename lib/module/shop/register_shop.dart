// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ShowDialogWidget extends StatelessWidget {
  const ShowDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Shop"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bạn chưa đăng ký bán hàng!",
              style: TextStyle(fontSize: 24),
            ),
            Container(
              padding: EdgeInsets.only(top: 40),
              child: ElevatedButton(
                child: Container(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                  child: Text(
                    "Đăng ký ngay",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/myshop");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
