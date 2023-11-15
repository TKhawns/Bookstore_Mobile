// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';

class PaymentService {
  Future<Response> requestPayment(
      String signature, String requestId, String orderInfo) {
    final dio = Dio();
    return dio.post(
      'https://test-payment.momo.vn/gw_payment/transactionProcessor',
      data: {
        "accessKey": "F8BBA842ECF85",
        "partnerCode": "MOMO",
        "requestType": "captureMoMoWallet",
        "notifyUrl": "http://localhost:58072/#/home",
        "returnUrl": "http://localhost:58072/#/home",
        "orderId": requestId,
        "amount": "15000",
        "orderInfo": "Payment Book",
        "requestId": requestId,
        "extraData": "trinhkhanhctdt@gmail.com",
        "signature": signature,
      },
    );
  }
}
