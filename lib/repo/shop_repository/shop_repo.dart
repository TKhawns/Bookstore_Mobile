// ignore_for_file: depend_on_referenced_packages, prefer_final_fields

import 'dart:async';

import 'package:bookstore_mobile/repo/shop_repository/shop_data.dart';
import 'package:bookstore_mobile/repo/shop_repository/shop_service.dart';
import 'package:dio/dio.dart';

import '../book_repository/book_data.dart';

class ShopRepo {
  ShopService _shopService;

  ShopRepo({required ShopService shopService}) : _shopService = shopService;

  Future<ShopData> getShopInfo(String shopname) async {
    var c = Completer<ShopData>();
    try {
      var response = await _shopService.getShopInfo(shopname);
      var shop = ShopData.fromJson(response.data);
      c.complete(shop);
    } on DioException {
      c.completeError(('Lỗi lấy thông tin shop'));
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<List<BookData>> getBookDetail(String shopname) async {
    var c = Completer<List<BookData>>();

    try {
      var response = await _shopService.getBookDetail(shopname);
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
