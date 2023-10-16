import 'dart:async';

import 'package:dio/dio.dart';
import '../../widget/shopping_cart.dart';
import 'book_order.dart';
import 'order_service.dart';

class OrderRepo {
  OrderService _orderService;

  OrderRepo({required OrderService orderService})
      : _orderService = orderService;

  // Future<ShoppingCart> addToCart(BookOrder bookData) async {
  //   var c = Completer<ShoppingCart>();
  //   try {
  //     var response = await _orderService.addToCart(bookData);
  //     var shoppingCart = ShoppingCart.fromJson(response.data['data']);
  //     c.complete(shoppingCart);
  //   } on DioException {
  //     c.completeError('Lỗi AddToCart');
  //   } catch (e) {
  //     c.completeError(e);
  //   }
  //   return c.future;
  // }

  Future<ShoppingCart> getShoppingCartInfo() async {
    var c = Completer<ShoppingCart>();
    try {
      var response = await _orderService.countShoppingCart();
      var shoppingCart = ShoppingCart.fromJson(response.data);
      c.complete(shoppingCart);
    } on DioException {
      c.completeError(('Lỗi lấy thông tin so luong order'));
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<List<BookOrder>> getOrderDetail() async {
    var c = Completer<List<BookOrder>>();

    try {
      var response = await _orderService.orderDetail();
      var bookList = BookOrder.parseBookOrderList(response.data);
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
