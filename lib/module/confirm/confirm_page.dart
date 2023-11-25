// ignore_for_file: unnecessary_import, depend_on_referenced_packages, prefer_const_constructors
import 'package:bookstore_mobile/module/checkout/checkout_bloc.dart';
import 'package:bookstore_mobile/module/confirm/confirm_event.dart';
import 'package:bookstore_mobile/repo/order_repository/order_repo.dart';
import 'package:bookstore_mobile/repo/order_repository/order_service.dart';
import 'package:bookstore_mobile/widget/normalbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flare_flutter/flare_actor.dart';

class ConfirmPage extends StatefulWidget {
  const ConfirmPage({super.key});

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  CheckoutBloc bloc =
      CheckoutBloc(orderRepo: OrderRepo(orderService: OrderService()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Status Order",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 100, bottom: 20),
            alignment: Alignment.center,
            height: 300,
            child: const FlareActor(
              "assets/videos/SuccessCheck.flr",
              alignment: Alignment.center,
              fit: BoxFit.fitHeight,
              // this animation name is name of animation in root link SuccessCheck.flr export from internet
              animation: "Untitled",
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 30, right: 30, bottom: 50),
            child: Text(
              "Đơn hàng của bạn đã được xác nhận",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 24),
            ),
          ),
          SizedBox(
              width: 250,
              child: NormalButton(
                  title: "Đồng ý",
                  onPressed: () {
                    bloc.event.add(ConfirmEvent());
                    Navigator.pushNamed(context, "/home",
                        arguments: '3af298e0-e126-4ce0-b957-b637869b2da3');
                  }))
        ],
      ),
    );
  }
}
