import 'package:flutter/material.dart';

class NormalButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  NormalButton({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          minimumSize: Size(350, 60),
          backgroundColor: const Color.fromARGB(255, 0, 151, 178),
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0))),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    ));
  }
}
