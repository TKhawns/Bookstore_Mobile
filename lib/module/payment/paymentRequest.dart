// ignore_for_file: file_names, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:crypto/crypto.dart';

class PaymentRequest {
//   {
//   "accessKey": "F8BBA842ECF85",
//   "partnerCode": "MOMO",
//   "requestType": "captureMoMoWallet",
//   "notifyUrl": "https://momo.vn",
//   "returnUrl": "https://momo.vn",
//   "orderId": "123456789876",
//   "amount": "150000",
//   "orderInfo": "SDK team.",
//   "requestId": "123456789876",
//   "extraData": "email=abc@gmail.com",
//   "signature": "4e2d01814f793e83fa1b2acb769ba815e3e6eaa17a1590a2b60b73fa031d73cc"
// }

  // final String accessKey = "F8BBA842ECF85";
  // final String partnerCode = "MOMO";
  // final String requestType = "captureMoMoWallet";
  // final String notifyUrl = "localhost:8080/home";
  // final String returnUrl = "localhost:8080/home";
  // final String orderId = DateTime.now().millisecondsSinceEpoch as String;
  // final String amount = "15,000 VND";
  // final String orderInfo = "";
  // final String requestId = DateTime.now().millisecondsSinceEpoch as String;
  // final String extraData = "trinhkhanhctdt@gmail.com";
  // final String signature = "";
  // final String secretKey = "K951B6PE1waDMi640xX08PD3vg6EkVlz";
  PaymentRequest();

  String computeSignature(
      String accessKey,
      String partnerCode,
      String requestType,
      String notifyUrl,
      String returnUrl,
      String orderId,
      String amount,
      String orderInfo,
      String requestId,
      String extraData,
      String secretKey) {
    String rawData =
        "partnerCode=${partnerCode}&accessKey=${accessKey}&requestId=${orderId}&amount=${amount}&orderId=${orderId}&orderInfo=${orderInfo}&returnUrl=${returnUrl}¬ifyUrl=${notifyUrl}&extraData=";
    var key = utf8.encode(secretKey);
    var bytes = utf8.encode(rawData);
    var hmacSha256 = Hmac(sha256, key);
    var digest = hmacSha256.convert(bytes) as String;
    // print(digest);
    return digest;
  }
}
