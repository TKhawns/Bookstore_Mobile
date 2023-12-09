// ignore_for_file: depend_on_referenced_packages, avoid_print, non_constant_identifier_names

import 'dart:convert';

import 'package:bookstore_mobile/base/base_event.dart';
import 'package:bookstore_mobile/repo/payment_repository/payment_data.dart';
import 'package:bookstore_mobile/repo/payment_repository/payment_repo.dart';

import '../../base/base_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:crypto/crypto.dart';

class PaymentBloc extends BaseBloc {
  final PaymentRepo _paymentRepo;
  PaymentBloc({required PaymentRepo paymentRepo}) : _paymentRepo = paymentRepo;

  final _paymentSubject = BehaviorSubject<ResponeData>();
  Stream<ResponeData> get paymentStream => _paymentSubject.stream;
  Sink<ResponeData> get paymentSink => _paymentSubject.sink;

  // @override
  // void dispatchEvent(BaseEvent event) {
  //   switch (event.runtimeType) {
  //     case UpdateCartEvent:
  //       handleUpdateCart(event);
  //       UpdateCartEvent e = event as UpdateCartEvent;
  //       getOrderDetail(e.customerId);
  //       break;
  //     case DeleteOrderEvent:
  //       handleDeleteOrder(event);
  //       UpdateCartEvent e = event as UpdateCartEvent;
  //       getOrderDetail(e.customerId);
  //       break;
  //   }
  // }

  Stream<ResponeData> getLinkPayment(String orderInfo) {
    var requestId_time = DateTime.now().microsecondsSinceEpoch;
    String requestId = requestId_time.toString();
    print(requestId);
    String rawData =
        "partnerCode=MOMO&accessKey=F8BBA842ECF85&requestId=$requestId&amount=15000&orderId=$requestId&orderInfo=Payment Book&returnUrl=http://localhost:58072/#/home&notifyUrl=http://localhost:58072/#/home&extraData=trinhkhanhctdt@gmail.com";
    var key = utf8.encode("K951B6PE1waDMi640xX08PD3vg6EkVlz");
    var bytes = utf8.encode(rawData);
    var hmacSha256 = Hmac(sha256, key);
    var digest = hmacSha256.convert(bytes);
    print(digest.toString());

    return Stream<ResponeData>.fromFuture(
      _paymentRepo.paymentResult(digest.toString(), requestId, orderInfo),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _paymentSubject.close();
  }

  @override
  void dispatchEvent(BaseEvent event) {
    // TODO: implement dispatchEvent
  }
}
