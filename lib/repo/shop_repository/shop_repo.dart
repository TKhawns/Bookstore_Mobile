import 'dart:async';

import 'package:bookstore_mobile/repo/shop_repository/shop_data.dart';
import 'package:bookstore_mobile/repo/shop_repository/shop_service.dart';
import 'package:dio/dio.dart';

class ShopRepo {
  ShopService _shopService;

  ShopRepo({required ShopService shopService}) : _shopService = shopService;

  Future<ShopData> getShopInfo() async {
    var c = Completer<ShopData>();
    try {
      var response = await _shopService.getShopInfo();
      var shop = ShopData.fromJson(response.data);
      c.complete(shop);
    } on DioException {
      c.completeError(('Lỗi lấy thông tin shop'));
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }
}
