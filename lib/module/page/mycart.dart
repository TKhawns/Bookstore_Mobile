// ignore_for_file: non_constant_identifier_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '../../repo/book_repository/book_data.dart';

class MyShoppingCart extends StatelessWidget {
  final List<BookData> books_cart = [];

  void addbooks(BookData book) {
    books_cart.add(book);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
