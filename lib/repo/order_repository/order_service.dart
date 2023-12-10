// ignore_for_file: depend_on_referenced_packages

import 'package:bookstore_mobile/repo/book_repository/book_data.dart';
import 'package:dio/dio.dart';

import '../../database/dio_get.dart';

class OrderService {
  Future<Response> countShoppingCart(String customerId) {
    return BookClient.instance.dio.post('/order/count', data: {
      'customer_id': customerId,
    });
  }

  Future<Response> getDataDashboard(String customerId) {
    return BookClient.instance.dio.post('/order/dash', data: {
      'customer_id': customerId,
    });
  }

  Future<Response> addToCart(BookData bookData, String customerId) {
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
        "customerId": customerId,
      },
    );
  }

  Future<Response> addToBook(BookData bookData) {
    return BookClient.instance.dio.post(
      '/home/add_book',
      data: {
        "book_id": bookData.book_id,
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

  Future<Response> orderList(String shopName) {
    return BookClient.instance.dio.post('/order/detail', data: {
      'shopName': shopName,
    });
  }

  Future<Response> getUserOrderList(String shopName) {
    return BookClient.instance.dio.post('/order/userdetail', data: {
      'shopName': shopName,
    });
  }

  Future<Response> updateOrder(BookData bookData, String customerId) {
    return BookClient.instance.dio.post(
      '/order/update',
      data: {
        'order_id': bookData.book_id,
        'quantity': bookData.quantity,
        'customer_id': customerId,
      },
    );
  }

  Future<Response> confirmOrder() {
    return BookClient.instance.dio.get(
      '/order/confirm',
    );
  }

  Future<Response> setPaymentStatus(String customerId) {
    return BookClient.instance.dio.post(
      '/order/payment_status',
      data: {
        'customerId': customerId,
      },
    );
  }

  Future<Response> deleteOrder(BookData bookData, String customerId) {
    return BookClient.instance.dio.post(
      '/order/delete',
      data: {
        'order_id': bookData.book_id,
        'customerId': customerId,
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
