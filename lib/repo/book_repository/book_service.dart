import 'package:dio/dio.dart';
import '../../database/dio_get.dart';

class BookService {
  Future<Response> bookInfo() {
    return BookClient.instance.dio.get(
      '/home/booklist',
    );
  }
}
