// ignore_for_file: unnecessary_null_comparison

import 'dart:async';

import 'package:bookstore_mobile/repo/order_repository/book_order.dart';
import 'package:bookstore_mobile/repo/order_repository/order_repo.dart';
import 'package:bookstore_mobile/repo/order_repository/order_service.dart';
import 'package:bookstore_mobile/widget/bloc_listener.dart';
import 'package:bookstore_mobile/widget/button_shopping.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../widget/order.dart';
import 'checkout_bloc.dart';

class CheckoutWidget extends StatefulWidget {
  const CheckoutWidget({super.key});

  @override
  State<CheckoutWidget> createState() => _CheckoutWidgetState();
}

class _CheckoutWidgetState extends State<CheckoutWidget> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: OrderService()),
        ProxyProvider<OrderService, OrderRepo>(
          update: (context, orderService, previous) =>
              OrderRepo(orderService: orderService),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "My Cart",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          backgroundColor: const Color.fromARGB(255, 0, 151, 178),
        ),
        body: ShoppingCartInfoWidget(),
      ),
    );
  }
}

class ShoppingCartInfoWidget extends StatefulWidget {
  const ShoppingCartInfoWidget({super.key});

  @override
  State<ShoppingCartInfoWidget> createState() => _ShoppingCartInfoWidgetState();
}

class _ShoppingCartInfoWidgetState extends State<ShoppingCartInfoWidget> {
  List<BookOrder> initData = [];

  @override
  Widget build(BuildContext context) {
    return Provider<CheckoutBloc>.value(
      value: CheckoutBloc(
        orderRepo: Provider.of(context),
      ),
      child: Consumer<CheckoutBloc>(
        builder: (context, bloc, child) {
          bloc.getOrderDetail().listen((event) {
            for (var i = 0; i < event.length; i++) {
              initData.add(event[i]);
            }
          });
          return BlocListener<CheckoutBloc>(
            listener: (event) {},
            child: StreamProvider<List<BookOrder>>.value(
              catchError: (context, error) {
                return [];
              },
              initialData: initData,
              value: bloc.getOrderDetail(),
              child: Consumer<List<BookOrder>>(
                builder: (context, value, child) {
                  if (value.isEmpty) {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (!value.isEmpty) {
                    return ListView(
                      children: newBuildBooks(value, context),
                    );
                  }
                  return Container();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

List<Widget> newBuildBooks(List<BookOrder> data, BuildContext context) {
  List<Widget> list = [];
  for (var i = 0; i < data.length; i++) {
    list.add(newbuildBook(data[i], i, context));
  }
  return list;
}

Widget newbuildBook(BookOrder book, int index, BuildContext context) {
  return Container(
    height: 180,
    child: Card(
      elevation: 3.0,
      child: Container(
        padding: EdgeInsets.only(left: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "assets/images/${book.image}",
                width: 100,
                height: 150,
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 15, left: 15, right: 10),
                  child: Text(
                    book.title,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, left: 15),
                  child: Text(
                    "100 books",
                    style: TextStyle(color: Colors.blue, fontSize: 17),
                  ),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5, left: 15),
                      child: Text(
                        book.cost,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 0, 151, 178),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                        ),
                        child: Text(
                          ' Buy now ',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    )
                  ],
                )),
              ],
            )),
          ],
        ),
      ),
    ),
  );
}
