// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, use_key_in_widget_constructors, must_be_immutable

import 'dart:ui';

import 'package:bookstore_mobile/module/order/order_bloc.dart';
import 'package:bookstore_mobile/repo/order_repository/order_repo.dart';
import 'package:bookstore_mobile/repo/order_repository/order_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'order_data.dart';

class UserOrderWidget extends StatelessWidget {
  String customerName;
  UserOrderWidget({required this.customerName});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserOrderWidget>(
          create: (_) => UserOrderWidget(
            customerName: "",
          ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Your orders",
            style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: UserOrderListWidget(
            shopName: customerName,
          ),
        ),
      ),
    );
  }
}

class UserOrderListWidget extends StatefulWidget {
  final String shopName;
  UserOrderListWidget({required this.shopName});

  @override
  State<UserOrderListWidget> createState() => _OrderListWidgetState();
}

class _OrderListWidgetState extends State<UserOrderListWidget> {
  List<OrderData> bookData = [];
  @override
  Widget build(BuildContext context) {
    return Provider<OrderBloc?>.value(
      value: OrderBloc(orderRepo: OrderRepo(orderService: OrderService())),
      child: Consumer<OrderBloc>(builder: (context, bloc, child) {
        bloc.getUserOrderList(widget.shopName).listen((event) {
          for (var book in event) {
            bookData.add(book);
          }
        });
        return StreamProvider<List<OrderData>?>.value(
          initialData: bookData,
          value: bloc.getUserOrderList(widget.shopName),
          child: Consumer<List<OrderData>?>(
            builder: (context, data, child) {
              if (data!.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.yellow,
                  ),
                );
              }

              return ListView(
                children: buildOrders(bookData),
              );
            },
          ),
        );
      }),
    );
  }

  List<Widget> buildOrders(List<OrderData> data) {
    List<Widget> list = [];
    for (var i = 0; i < data.length; i++) {
      list.add(buildOrder(data[i], i));
    }
    return list;
  }

  Widget buildOrder(OrderData orderData, int index) {
    return SizedBox(
      height: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            child: Container(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      orderData.title,
                      style: GoogleFonts.inter(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      "Đã xác nhận",
                      style: GoogleFonts.inter(
                          color: Color.fromARGB(255, 0, 151, 178),
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/images/${orderData.image}",
                    width: 100,
                    height: 110,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 2),
                        child: Text(
                          "Cửa hàng: ${orderData.name}",
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          "Địa chỉ: ${orderData.address}",
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "7 ngày trả hàng",
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: Colors.red),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 90),
                            child: Text(
                              "x${orderData.count}",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 21,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
