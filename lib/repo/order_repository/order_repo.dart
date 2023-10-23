import 'dart:async';

import 'package:dio/dio.dart';
import '../../widget/shopping_cart.dart';
import '../book_repository/book_data.dart';
import 'order_service.dart';

class OrderRepo {
  OrderService _orderService;

  OrderRepo({required OrderService orderService})
      : _orderService = orderService;

  Future<ShoppingCart> addToCart(BookData bookData) async {
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

  Future<List<BookData>> getOrderDetail() async {
    var c = Completer<List<BookData>>();

    try {
      var response = await _orderService.orderDetail();
      var bookList = BookData.parseBookDataList(response.data);
      c.complete(bookList);
    } on DioException {
      c.completeError("Get book fail");
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }
}
