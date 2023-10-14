import 'package:bookstore_mobile/repo/book_repository/book_data.dart';
import 'package:dio/dio.dart';

import '../../database/dio_get.dart';
import '../book_repository/book_order.dart';

class OrderService {
  Future<Response> countShoppingCart() {
    return BookClient.instance.dio.get(
      '/order/count',
    );
  }

  Future<Response> addToCart(BookOrder bookData) {
    return BookClient.instance.dio.post(
      '/order/add',
      data: {
        "order_id": bookData.order_id,
        "title": bookData.title,
        "description": bookData.description,
        "price": bookData.cost,
        "shipcost": bookData.shipCost,
      },
    );
  }

  // Future<Response> orderDetail(String orderId) {
  //   return BookClient.instance.dio.get(
  //     '/order/list',
  //     queryParameters: {
  //       'order_id': orderId,
  //     },
  //   );
  // }

  // Future<Response> updateOrder(BookData bookData) {
  //   return BookClient.instance.dio.post(
  //     '/order/update',
  //     data: {
  //       'orderId': product.orderId,
  //       'quantity': product.quantity,
  //       'productId': product.productId,
  //     },
  //   );
  // }

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
