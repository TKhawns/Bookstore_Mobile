// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors, prefer_is_not_empty, use_key_in_widget_constructors, unnecessary_import, depend_on_referenced_packages, sized_box_for_whitespace, avoid_print, prefer_const_constructors_in_immutables
import 'dart:ui';

import 'package:bookstore_mobile/event/delete_order_event.dart';
import 'package:bookstore_mobile/event/should_rebuild_event.dart';
import 'package:bookstore_mobile/module/payment/payment.dart';
import 'package:bookstore_mobile/repo/order_repository/order_repo.dart';
import 'package:bookstore_mobile/repo/order_repository/order_service.dart';
import 'package:bookstore_mobile/widget/bloc_listener.dart';
import 'package:bookstore_mobile/widget/button_shopping.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../../base/base_event.dart';
import '../../event/update_quantity_event.dart';
import '../../repo/book_repository/book_data.dart';
import '../../repo/user_repository/user_repo.dart';
import '../../repo/user_repository/user_service.dart';
import 'checkout_bloc.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutWidget extends StatelessWidget {
  const CheckoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Object? customerId = ModalRoute.of(context)!.settings.arguments;
    return MultiProvider(
      providers: [
        Provider<CheckoutWidget>(
          create: (_) => CheckoutWidget(),
        ),
        Provider.value(
          value: UserService(),
        ),
        ProxyProvider<UserService, UserRepo>(
          update: (context, userService, previous) =>
              UserRepo(userService: userService),
        ),
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
            style: GoogleFonts.inter(color: Colors.white, fontSize: 25),
          ),
          backgroundColor: const Color.fromARGB(255, 0, 151, 178),
        ),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: ShoppingCartInfoWidget(
            customerId: customerId as String,
          ),
        ),
      ),
    );
  }
}

class ShoppingCartInfoWidget extends StatefulWidget {
  final String customerId;
  ShoppingCartInfoWidget({required this.customerId});

  @override
  State<ShoppingCartInfoWidget> createState() => _ShoppingCartInfoWidgetState();
}

class _ShoppingCartInfoWidgetState extends State<ShoppingCartInfoWidget> {
  List<BookData> initData = [];
  int totalPrice = 0;
  bool shouldRebuild = true;

  handleEvent(BaseEvent event) {
    //totalPrice = 0;
    if (event is ShouldRebuildEvent || event is DeleteOrderEvent) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provider<CheckoutBloc>.value(
      value: CheckoutBloc(
        orderRepo: Provider.of(context),
      ),
      child: Consumer<CheckoutBloc>(
        builder: (context, bloc, child) {
          bloc.getOrderDetail(widget.customerId).listen((event) {
            totalPrice = 0;
            for (var book in event) {
              initData.add(book);
              totalPrice += int.parse(book.cost) * int.parse(book.quantity);
            }
          });
          return BlocListener<CheckoutBloc>(
            listener: handleEvent,
            child: StreamProvider<List<BookData>>.value(
              catchError: (context, error) {
                return [];
              },
              initialData: initData,
              updateShouldNotify: (prev, current) {
                return shouldRebuild;
              },
              value: bloc.getOrderDetail(widget.customerId),
              child: Consumer<List<BookData>>(
                builder: (context, value, child) {
                  if (value.isEmpty) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!value.isEmpty) {
                    return Column(
                      children: [
                        Expanded(
                          child: ListView(
                            children: newBuildBooks(
                                value, context, bloc, widget.customerId),
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              height: 2,
                              color: Colors.grey[300],
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 60,
                              child: Text(
                                "Địa chỉ nhận hàng: Xuân Thủy, Hà Nội\nKhách hàng: Trinh Khanh",
                                style: GoogleFonts.inter(
                                    color: Colors.grey[800], fontSize: 20),
                              ),
                            ),
                            Container(
                              height: 2,
                              color: Colors.grey[300],
                            ),
                            Container(
                              height: 70,
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Tổng thanh toán:",
                                          style: GoogleFonts.inter(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          '${MoneyFormatter(amount: double.parse(totalPrice.toString())).output.withoutFractionDigits} VND',
                                          style: GoogleFonts.inter(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      width: 150,
                                      height: 67,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PaymentWidget(
                                                      customerId:
                                                          widget.customerId,
                                                      total:
                                                          totalPrice.toString(),
                                                    )),
                                          );
                                        },
                                        child: Text(
                                          "Mua hàng",
                                          style: GoogleFonts.inter(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
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

List<Widget> newBuildBooks(List<BookData> data, BuildContext context,
    CheckoutBloc bloc, String customerId) {
  List<Widget> list = [];
  for (var i = 0; i < data.length; i++) {
    list.add(newbuildBook(data[i], i, context, bloc, customerId));
  }
  return list;
}

Widget newbuildBook(BookData book, int index, BuildContext context,
    CheckoutBloc bloc, String customerId) {
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
                    maxLines: 1,
                    style: GoogleFonts.inter(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 15),
                  child: Text(
                    "Sách được bảo hiểm bằng BookCare",
                    style: GoogleFonts.inter(
                        color: Colors.grey[500], fontSize: 17),
                  ),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 5, left: 15),
                          child: Text(
                            '${MoneyFormatter(amount: double.parse(book.cost)).output.withoutFractionDigits} VND',
                            style: GoogleFonts.inter(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15, top: 5),
                          child: Row(
                            children: [
                              BtnCartAction(
                                title: '-',
                                onPressed: () {
                                  book.quantity =
                                      (int.parse(book.quantity) - 1).toString();
                                  bloc.event
                                      .add(UpdateCartEvent(book, customerId));
                                },
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(book.quantity,
                                  style: GoogleFonts.inter(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)),
                              SizedBox(
                                width: 15,
                              ),
                              BtnCartAction(
                                title: '+',
                                onPressed: () {
                                  book.quantity =
                                      (int.parse(book.quantity) + 1).toString();
                                  bloc.event
                                      .add(UpdateCartEvent(book, customerId));
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      child: ElevatedButton(
                        onPressed: () {
                          bloc.event.add(DeleteOrderEvent(book, customerId));
                        },
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
                          'Delete',
                          style: GoogleFonts.inter(
                              color: Colors.white, fontSize: 18),
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
