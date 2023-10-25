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

  Future<Response> orderDetail() {
    return BookClient.instance.dio.get(
      '/order/list',
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
