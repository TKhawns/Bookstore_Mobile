// ignore_for_file: unused_local_variable, depend_on_referenced_packages, prefer_final_fields

import 'dart:async';

import 'package:dio/dio.dart';
import '../../module/dashboard/darh_board_data.dart';
import '../../module/order/order_data.dart';
import '../../widget/shopping_cart.dart';
import '../book_repository/book_data.dart';
import 'order_service.dart';

class OrderRepo {
  OrderService _orderService;

  OrderRepo({required OrderService orderService})
      : _orderService = orderService;

  Future<ShoppingCart> addToCart(BookData bookData, String customerId) async {
    var c = Completer<ShoppingCart>();
    try {
      var response = await _orderService.addToCart(bookData, customerId);
      var shoppingCart = ShoppingCart.fromJson(response.data);
      c.complete(shoppingCart);
    } on DioException {
      c.completeError('Lỗi AddToCart');
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<DashBoardData> getDataDashboard(String customerId) async {
    var c = Completer<DashBoardData>();
    try {
      var response = await _orderService.getDataDashboard(customerId);
      var data = DashBoardData.fromJson(response.data);
      c.complete(data);
    } on DioException {
      c.completeError('Lỗi get data dash board');
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<bool> addToBooks(BookData bookData) async {
    var c = Completer<bool>();
    try {
      var response = await _orderService.addToBook(bookData);
      c.complete(true);
    } on DioException {
      c.completeError('Lỗi AddToBook');
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<ShoppingCart> getShoppingCartInfo(String customerId) async {
    var c = Completer<ShoppingCart>();
    try {
      var response = await _orderService.countShoppingCart(customerId);
      var shoppingCart = ShoppingCart.fromJson(response.data);
      c.complete(shoppingCart);
    } on DioException {
      c.completeError(('Lỗi lấy thông tin so luong order'));
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<List<BookData>> getOrderDetail(String customerId) async {
    var c = Completer<List<BookData>>();

    try {
      var response = await _orderService.orderDetail(customerId);
      var bookList = BookData.parseBookDataList(response.data);
      c.complete(bookList);
    } on DioException {
      c.completeError("Get book fail");
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<List<OrderData>> getOrderList(String shopName) async {
    var c = Completer<List<OrderData>>();

    try {
      var response = await _orderService.orderList(shopName);
      var bookList = OrderData.parseBookDataList(response.data);
      c.complete(bookList);
    } on DioException {
      c.completeError("Get book fail");
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<List<OrderData>> getUserOrderList(String shopName) async {
    var c = Completer<List<OrderData>>();

    try {
      var response = await _orderService.getUserOrderList(shopName);
      var bookList = OrderData.parseBookDataList(response.data);
      c.complete(bookList);
    } on DioException {
      c.completeError("Get user orders fail");
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<bool> updateOrder(BookData bookData, String customerId) async {
    var c = Completer<bool>();
    try {
      await _orderService.updateOrder(bookData, customerId);
      c.complete(true);
    } on DioException {
      c.completeError('Lỗi update đơn hàng');
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<bool> confirmOrder() async {
    var c = Completer<bool>();
    try {
      await _orderService.confirmOrder();
      c.complete(true);
    } on DioException {
      c.completeError('Lỗi confirm đơn hàng');
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<bool> setPaymentStatus(String customerId) async {
    var c = Completer<bool>();
    try {
      await _orderService.setPaymentStatus(customerId);
      c.complete(true);
    } on DioException {
      c.completeError('Lỗi set payment status đơn hàng');
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<bool> deleteOrder(BookData bookData, String customerId) async {
    var c = Completer<bool>();
    try {
      await _orderService.deleteOrder(bookData, customerId);
      c.complete(true);
    } on DioException {
      c.completeError('Lỗi update đơn hàng');
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }
}
