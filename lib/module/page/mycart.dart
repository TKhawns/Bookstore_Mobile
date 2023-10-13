import 'package:flutter/material.dart';

import '../../repo/book_repository/book_data.dart';

class ShoppingCart extends StatelessWidget {
  final List<BookData> books_cart = [];

  void addbooks(BookData book) {
    books_cart.add(book);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
