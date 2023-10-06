// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_final_fields, depend_on_referenced_packages, prefer_interpolation_to_compose_strings

import 'package:bookstore_mobile/database/spref.dart';
import 'package:dio/dio.dart';

import 'constant.dart';

class BookClient {
  static BaseOptions _options = new BaseOptions(
    baseUrl: "http://localhost:8080",
    connectTimeout: Duration(seconds: 5000),
    receiveTimeout: Duration(seconds: 3000),
  );

  static final Dio _dio = Dio(_options);

  BookClient._internal() {
    _dio.interceptors.add(LogInterceptor(responseBody: true));
    _dio.interceptors.add(InterceptorsWrapper(onRequest:
        (RequestOptions myOption, RequestInterceptorHandler handler) async {
      var token = await SPref.instance.get(SPrefCache.KEY_TOKEN);
      if (token != null) {
        myOption.headers["Authorization"] = "Bearer " + token;
      }

      return handler.next(myOption);
    }));
  }
  static final BookClient instance = BookClient._internal();
  Dio get dio => _dio;
  Dio dioo = Dio();
}
