// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import '../../database/dio_get.dart';

class BookService {
  Future<Response> bookInfo() {
    return BookClient.instance.dio.get(
      '/home/booklist',
    );
  }

  Future<Response> searchBook(String title) {
    return BookClient.instance.dio.post(
      '/home/search',
      data: {
        'title': title,
      },
    );
  }
}
