// ignore_for_file: prefer_final_fields, unnecessary_null_comparison, unused_catch_clause, depend_on_referenced_packages

import 'dart:async';

import 'package:bookstore_mobile/repo/payment_repository/payment_data.dart';
import 'package:bookstore_mobile/repo/payment_repository/payment_service.dart';
import 'package:dio/dio.dart';

class PaymentRepo {
  PaymentService _paymentService;
  PaymentRepo({required PaymentService paymentService})
      : _paymentService = paymentService;

  Future<ResponeData> paymentResult(
      String signature, String requestId, String orderInfo) async {
    var c = Completer<ResponeData>();

    try {
      var response = await _paymentService.requestPayment(
          signature, requestId, "Payment Book");
      var responseData = ResponeData.fromJson(response.data);
      print("Test respont: $responseData");
      c.complete(responseData);
    } on DioException {
      c.completeError("Get result payment fail");
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }
}
