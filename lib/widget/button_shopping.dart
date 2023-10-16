// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';

class BtnCartAction extends StatelessWidget {
  final title;
  final VoidCallback onPressed;

  BtnCartAction({required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 42,
      height: 42,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(7.0)),
        ),
        child: SizedBox(
          width: 32,
          height: 32,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 151, 178),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
