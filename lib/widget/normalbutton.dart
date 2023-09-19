import 'package:flutter/material.dart';

class NormalButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  NormalButton({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        minWidth: 200,
        height: 45.0,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              minimumSize: Size(110, 50),
              backgroundColor: Colors.yellow,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(4.0))),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
        ));
  }
}
