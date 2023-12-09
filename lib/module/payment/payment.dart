// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors, must_be_immutable, deprecated_member_use, no_leading_underscores_for_local_identifiers, avoid_print, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:bookstore_mobile/module/checkout/checkout_bloc.dart';
import 'package:bookstore_mobile/module/payment/payment_bloc.dart';
import 'package:bookstore_mobile/module/payment/payment_event.dart';
import 'package:bookstore_mobile/repo/order_repository/order_repo.dart';
import 'package:bookstore_mobile/repo/order_repository/order_service.dart';
import 'package:bookstore_mobile/repo/payment_repository/payment_repo.dart';
import 'package:bookstore_mobile/repo/payment_repository/payment_service.dart';
import 'package:bookstore_mobile/widget/normalbutton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:money_formatter/money_formatter.dart';

// String computeSignature() {
//   var requestId_time = DateTime.now().microsecondsSinceEpoch;
//   String requestId = requestId_time.toString();
//   print(requestId);
//   String rawData =
//       "partnerCode=MOMO&accessKey=F8BBA842ECF85&requestId=$requestId&amount=15000&orderId=$requestId&orderInfo=Payment Book&returnUrl=localhost:8080/home&notifyUrl=localhost:8080/home&extraData=trinhkhanhctdt@gmail.com";
//   var key = utf8.encode("K951B6PE1waDMi640xX08PD3vg6EkVlz");
//   var bytes = utf8.encode(rawData);
//   var hmacSha256 = Hmac(sha256, key);
//   var digest = hmacSha256.convert(bytes);

//   return digest.toString();
// }

class PaymentWidget extends StatefulWidget {
  final String customerId;
  final String total;
  PaymentWidget({required this.customerId, required this.total});

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  // String signature = computeSignature();

  Future<void> _launchUrl(String url) async {
    Uri _url = Uri.parse(url);
    if (!await launchUrl(_url,
        mode: LaunchMode.inAppWebView, webOnlyWindowName: '_self')) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    PaymentBloc paymentBloc =
        PaymentBloc(paymentRepo: PaymentRepo(paymentService: PaymentService()));
    CheckoutBloc bloc =
        CheckoutBloc(orderRepo: OrderRepo(orderService: OrderService()));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Create Payment",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCustomerName(),
          Container(
            height: 3,
          ),
          _buildContentPayment(),
          Container(
            height: 1,
            color: Colors.grey,
            margin: EdgeInsets.only(left: 20, right: 20),
          ),
          Container(
            height: 3,
          ),
          _buildAmount(widget.total),
          Container(
            height: 3,
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            child: NormalButton(
                title: "Xác nhận",
                onPressed: () {
                  bloc.event.add(PaymentEvent(widget.customerId));
                  paymentBloc.getLinkPayment("Testpayment").listen((event) {
                    print(event.payUrl);
                    _launchUrl(event.payUrl);
                  });
                }),
          )
        ],
      ),
    );
  }

  Widget _buildCustomerName() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 15),
            child: Text(
              "Tên khách hàng",
              style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
          TextField(
            cursorColor: Colors.black,
            obscureText: false,
            decoration: InputDecoration(
              hintText: "Enter text",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentPayment() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 15),
            child: Text(
              "Nội dung thanh toán",
              style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            "Payment Book",
            style: GoogleFonts.inter(
                color: Colors.grey, fontSize: 17, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildAmount(String total) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 15),
            child: Text(
              "Số tiền",
              style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            '${MoneyFormatter(amount: double.parse(total)).output.withoutFractionDigits} VND',
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w500, color: Colors.red, fontSize: 17),
          ),
        ],
      ),
    );
  }
}
