// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import '../../database/dio_get.dart';

class AuthorService {
  Future<Response> authorInfo() {
    return BookClient.instance.dio.get(
      '/home/authorlist',
    );
  }
}
