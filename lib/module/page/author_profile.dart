import 'package:bookstore_mobile/widget/author_list.dart';
import 'package:flutter/material.dart';

class AuthorProfile extends StatelessWidget {
  final Author author;
  AuthorProfile({required this.author});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Author Information",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 151, 178),
      ),
      body: Stack(
        children: [
          Image.asset(
            author.image,
            fit: BoxFit.fitWidth,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 48,
              left: 32,
            ),
          ),
        ],
      ),
    );
  }
}
