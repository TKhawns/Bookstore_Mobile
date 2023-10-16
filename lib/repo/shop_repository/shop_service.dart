import 'package:dio/dio.dart';

import '../../database/dio_get.dart';

class ShopService {
  Future<Response> getShopInfo() {
    return BookClient.instance.dio.get(
      '/shop/info',
    );
  }
}
