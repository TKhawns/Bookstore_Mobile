import 'package:bookstore_mobile/widget/book_list.dart';
import 'package:flutter/material.dart';

class BookDetail extends StatelessWidget {
  final Book book;

  BookDetail({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Hero(
              tag: book.title,
              child: Image.asset(
                book.image,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50, left: 15),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 151, 178),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
