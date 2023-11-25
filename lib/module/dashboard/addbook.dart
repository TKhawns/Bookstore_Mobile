// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, avoid_print

import 'dart:ui';

import 'package:bookstore_mobile/event/add_to_cart_event.dart';
import 'package:bookstore_mobile/module/dashboard/addbook_success_event.dart';
import 'package:bookstore_mobile/module/dashboard/dash_board_bloc.dart';
import 'package:bookstore_mobile/repo/book_repository/book_data.dart';
import 'package:bookstore_mobile/repo/order_repository/order_repo.dart';
import 'package:bookstore_mobile/repo/order_repository/order_service.dart';
import 'package:bookstore_mobile/widget/bloc_listener.dart';
import 'package:flutter/material.dart';
import '../../base/base_event.dart';
import '../../widget/normalbutton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddBookPage extends StatelessWidget {
  const AddBookPage({super.key});

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
            "Add new Book",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: AddBookPageWidget(),
      ),
    );
  }
}

class AddBookPageWidget extends StatefulWidget {
  const AddBookPageWidget({super.key});

  @override
  State<AddBookPageWidget> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPageWidget> {
  final TextEditingController _txtTitleController = TextEditingController();
  final TextEditingController _txtPriceController = TextEditingController();
  final TextEditingController _txtDescriptionController =
      TextEditingController();
  final TextEditingController _txtScoreController = TextEditingController();
  final TextEditingController _txtQuantityController = TextEditingController();
  final TextEditingController _txtAuthorController = TextEditingController();
  final TextEditingController _txtImageController = TextEditingController();

  handleEvent(BaseEvent event) {
    if (event is AddToBookSuccess) {
      print("success");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provider<DashBoardBloc>.value(
        value: DashBoardBloc(orderRepo: Provider.of(context)),
        child: Consumer<DashBoardBloc>(builder: (context, bloc, child) {
          return BlocListener<DashBoardBloc>(
            listener: handleEvent,
            child: Column(
              children: [
                Expanded(
                  child: ScrollConfiguration(
                    behavior:
                        ScrollConfiguration.of(context).copyWith(dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                    }),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding:
                                EdgeInsets.only(left: 15, top: 15, bottom: 15),
                            child: Text(
                              "Please fill this Form",
                              style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 23),
                            ),
                          ),
                          Container(
                            height: 15,
                            color: Colors.grey[200],
                          ),
                          _buildNameBook(bloc),
                          Container(
                            height: 15,
                            color: Colors.grey[200],
                          ),
                          _buildPriceBook(bloc),
                          Container(
                            height: 15,
                            color: Colors.grey[200],
                          ),
                          _buildDescriptionBook(bloc),
                          Container(
                            height: 15,
                            color: Colors.grey[200],
                          ),
                          _buildScoreBook(bloc),
                          Container(
                            height: 15,
                            color: Colors.grey[200],
                          ),
                          _buildQuantityBook(bloc),
                          Container(
                            height: 15,
                            color: Colors.grey[200],
                          ),
                          _buildAuthorBook(bloc),
                          Container(
                            height: 15,
                            color: Colors.grey[200],
                          ),
                          _buildImageBook(bloc),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 2,
                  color: Colors.grey[400],
                ),
                Container(
                  height: 70,
                  padding:
                      EdgeInsets.only(bottom: 15, left: 60, right: 60, top: 10),
                  child: NormalButton(
                    title: "Add",
                    onPressed: () {
                      bloc.event.add(AddToCartEvent(
                        BookData(
                            book_id: 26,
                            title: _txtTitleController.text,
                            description: _txtDescriptionController.text,
                            cost: _txtPriceController.text,
                            authorName: _txtAuthorController.text,
                            image: _txtImageController.text,
                            count: int.parse(_txtQuantityController.text),
                            score: _txtScoreController.text,
                            shipCost: "15,000  VND",
                            shopName: "Book Store",
                            shop_image:
                                "https://i.pinimg.com/564x/41/75/fd/4175fd839e97e8af3fc8ad862ad4950f.jpg",
                            quantity: "1"),
                        "3af298e0-e126-4ce0-b957-b637869b2da3",
                      ));
                    },
                  ),
                ),
              ],
            ),
          );
        }));
  }

  Widget _buildNameBook(DashBoardBloc bloc) {
    return StreamProvider<String?>.value(
      value: bloc.titleStream,
      initialData: null,
      child: Consumer<String?>(
        builder: (context, value, child) => Container(
          padding: EdgeInsets.only(left: 20),
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  "Book's Name",
                  style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              TextField(
                controller: _txtTitleController,
                onChanged: (text) {
                  bloc.titleSink.add(text);
                  print(text);
                },
                cursorColor: Colors.black,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: "Enter text",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceBook(DashBoardBloc bloc) {
    return StreamProvider<String?>.value(
      value: bloc.titleStream,
      initialData: null,
      child: Consumer<String?>(
        builder: (context, value, child) => Container(
          padding: EdgeInsets.only(left: 20),
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        "Book's Price",
                        style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    TextField(
                      controller: _txtPriceController,
                      onChanged: (text) {
                        bloc.priceSink.add(text);
                        print(text);
                      },
                      cursorColor: Colors.black,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: "Enter text",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionBook(DashBoardBloc bloc) {
    return StreamProvider<String?>.value(
      value: bloc.titleStream,
      initialData: null,
      child: Consumer<String?>(
        builder: (context, value, child) => Container(
          padding: EdgeInsets.only(left: 20),
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        "Book's Description",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 20),
                      ),
                    ),
                    TextField(
                      controller: _txtDescriptionController,
                      onChanged: (text) {
                        bloc.descriptionSink.add(text);
                        print(text);
                      },
                      cursorColor: Colors.black,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: "Enter text",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreBook(DashBoardBloc bloc) {
    return StreamProvider<String?>.value(
      value: bloc.titleStream,
      initialData: null,
      child: Consumer<String?>(
        builder: (context, value, child) => Container(
          padding: EdgeInsets.only(left: 20),
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        "Book's Score",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 20),
                      ),
                    ),
                    TextField(
                      controller: _txtScoreController,
                      onChanged: (text) {
                        bloc.scoreSink.add(text);
                        print(text);
                      },
                      cursorColor: Colors.black,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: "Enter text",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityBook(DashBoardBloc bloc) {
    return StreamProvider<String?>.value(
      value: bloc.titleStream,
      initialData: null,
      child: Consumer<String?>(
        builder: (context, value, child) => Container(
          padding: EdgeInsets.only(left: 20),
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        "Book's Quantity",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 20),
                      ),
                    ),
                    TextField(
                      controller: _txtQuantityController,
                      onChanged: (text) {
                        bloc.quantitySink.add(text);
                        print(text);
                      },
                      cursorColor: Colors.black,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: "Enter text",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAuthorBook(DashBoardBloc bloc) {
    return StreamProvider<String?>.value(
      value: bloc.titleStream,
      initialData: null,
      child: Consumer<String?>(
        builder: (context, value, child) => Container(
          padding: EdgeInsets.only(left: 20),
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        "Book's Author",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 20),
                      ),
                    ),
                    TextField(
                      controller: _txtAuthorController,
                      onChanged: (text) {
                        bloc.authorSink.add(text);
                        print(text);
                      },
                      cursorColor: Colors.black,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: "Enter text",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageBook(DashBoardBloc bloc) {
    return StreamProvider<String?>.value(
      value: bloc.titleStream,
      initialData: null,
      child: Consumer<String?>(
        builder: (context, value, child) => Container(
          padding: EdgeInsets.only(left: 20),
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        "Book's Image",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 20),
                      ),
                    ),
                    TextField(
                      controller: _txtImageController,
                      onChanged: (text) {
                        bloc.imageSink.add(text);
                        print(text);
                      },
                      cursorColor: Colors.black,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: "Enter text",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
