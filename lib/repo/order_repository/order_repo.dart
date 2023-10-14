import 'dart:async';

import 'package:bookstore_mobile/repo/book_repository/book_data.dart';
import 'package:dio/dio.dart';
import '../../widget/shopping_cart.dart';
import '../book_repository/book_order.dart';
import 'order_service.dart';

class OrderRepo {
  OrderService _orderService;

  OrderRepo({required OrderService orderService})
      : _orderService = orderService;

  Future<ShoppingCart> addToCart(BookOrder bookData) async {
    var c = Completer<ShoppingCart>();
    try {
      var response = await _orderService.addToCart(bookData);
      var shoppingCart = ShoppingCart.fromJson(response.data['data']);
      c.complete(shoppingCart);
    } on DioException {
      c.completeError('Lỗi AddToCart');
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

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

  // Future<Order> getOrderDetail() async {
  //   var c = Completer<Order>();
  //   try {
  //     var response = await _orderService.orderDetail(_orderId);
  //     if (response.data['data']['items'] != null) {
  //       var order = Order.fromJson(response.data['data']);
  //       c.complete(order);
  //     } else {
  //       c.completeError(RestError.fromData('Không lấy được đơn hàng'));
  //     }
  //   } on DioError {
  //     c.completeError(RestError.fromData('Không lấy được đơn hàng'));
  //   } catch (e) {
  //     c.completeError(RestError.fromData(e.toString()));
  //   }
  //   return c.future;
  // }
}
