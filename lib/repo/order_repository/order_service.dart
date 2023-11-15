// ignore_for_file: depend_on_referenced_packages

import 'package:bookstore_mobile/repo/book_repository/book_data.dart';
import 'package:dio/dio.dart';

import '../../database/dio_get.dart';

class OrderService {
  Future<Response> countShoppingCart() {
    return BookClient.instance.dio.get(
      '/order/count',
    );
  }

  Future<Response> addToCart(BookData bookData) {
    return BookClient.instance.dio.post(
      '/order/add',
      data: {
        "order_id": bookData.book_id,
        "title": bookData.title,
        "description": bookData.description,
        "price": bookData.cost,
        "shipcost": bookData.shipCost,
        "shopname": bookData.shopName,
        "shop_image": bookData.shop_image,
        "score": bookData.score,
        "authorname": bookData.authorName,
        "number_books": bookData.count,
        "image": bookData.image,
        "quantity": bookData.quantity,
      },
    );
  }

  Future<Response> addToBook(BookData bookData) {
    return BookClient.instance.dio.post(
      '/home/add_book',
      data: {
        "book_id": 26,
        "title": bookData.title,
        "description": bookData.description,
        "price": bookData.cost,
        "shipcost": bookData.shipCost,
        "shopname": bookData.shopName,
        "shop_image": bookData.shop_image,
        "score": bookData.score,
        "authorname": bookData.authorName,
        "number_books": bookData.count,
        "image": bookData.image,
        "quantity": "1",
      },
    );
  }

  Future<Response> orderDetail(String customerId) {
    return BookClient.instance.dio.post(
      '/order/list',
      data: {
        'customerId': customerId,
      },
    );
  }

  Future<Response> updateOrder(BookData bookData) {
    return BookClient.instance.dio.post(
      '/order/update',
      data: {
        'order_id': bookData.book_id,
        'quantity': bookData.quantity,
      },
    );
  }

  Future<Response> deleteOrder(BookData bookData) {
    return BookClient.instance.dio.post(
      '/order/delete',
      data: {
        'order_id': bookData.book_id,
      },
    );
  }

  // Future<Response> confirm(String orderId) {
  //   return BookClient.instance.dio.post(
  //     '/order/confirm',
  //     data: {
  //       'orderId': orderId,
  //       'status': 'CONFIRM',
  //     },
  //   );
  // }
}
