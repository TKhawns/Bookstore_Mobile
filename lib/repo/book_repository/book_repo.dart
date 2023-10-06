// ignore_for_file: prefer_final_fields, unnecessary_null_comparison, unused_catch_clause, depend_on_referenced_packages

import 'dart:async';

import 'package:bookstore_mobile/repo/book_repository/book_data.dart';
import 'package:bookstore_mobile/repo/book_repository/book_service.dart';
import 'package:dio/dio.dart';

class BookRepo {
  BookService _bookService;
  BookRepo({required BookService bookService}) : _bookService = bookService;

  Future<List<BookData>> bookList() async {
    var c = Completer<List<BookData>>();

    try {
      var response = await _bookService.bookInfo();
      var bookList = BookData.parseBookDataList(response.data);
      print("test data");
      for (var book in bookList) {
        print("title: ${book.title}");
      }
      c.complete(bookList);
    } on DioException {
      c.completeError("Get book fail");
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }
}
