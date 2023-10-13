// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:bookstore_mobile/module/page/mycart.dart';
import 'package:bookstore_mobile/repo/author_repository/author_repo.dart';
import 'package:bookstore_mobile/repo/author_repository/author_service.dart';
import 'package:bookstore_mobile/repo/book_repository/book_data.dart';
import 'package:provider/provider.dart';
import 'package:bookstore_mobile/widget/book_list.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

import '../../repo/book_repository/book_repo.dart';
import '../../repo/book_repository/book_service.dart';
import '../home/book_detail.dart';
import '../home/home_bloc.dart';

class HotBook extends StatefulWidget {
  const HotBook({super.key});

  @override
  State<HotBook> createState() => _HotBookState();
}

class _HotBookState extends State<HotBook> {
  List<Book> books = getBookList();
  List<BookData> bookData = [];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<HotBook>(
          create: (_) => HotBook(),
        ),
        Provider.value(
          value: BookService(),
        ),
        ProxyProvider<BookService, BookRepo>(
          update: (context, bookService, previous) =>
              BookRepo(bookService: bookService),
        ),
        Provider.value(
          value: AuthorService(),
        ),
        ProxyProvider<AuthorService, AuthorRepo>(
          update: (context, authorService, previous) =>
              AuthorRepo(authorService: authorService),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Hot Books",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          backgroundColor: const Color.fromARGB(255, 0, 151, 178),
          actions: [
            Container(
                margin: EdgeInsets.only(top: 15, right: 30),
                child: badges.Badge(
                  badgeContent: Text(
                    '1',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Icon(
                    Icons.shopping_cart,
                    size: 30,
                  ),
                )),
          ],
        ),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: BookListWidget(),
        ),
      ),
    );
  }
}

class BookListWidget extends StatelessWidget {
  List<BookData> bookData = [];
  ShoppingCart updatebooks = ShoppingCart();

  Widget build(BuildContext context) {
    return Provider<HomeBloc?>.value(
      value: HomeBloc.getInstance(
          bookRepo: Provider.of(context), authorRepo: Provider.of(context)),
      child: Consumer<HomeBloc>(builder: (context, bloc, child) {
        bloc.getBookList().listen((event) {
          for (var book in event) {
            print("Title: ${book.title}");
            bookData.add(book);
          }
        });
        return StreamProvider<List<BookData>?>.value(
          initialData: bookData,
          value: bloc.getBookList(),
          child: Consumer<List<BookData>?>(
            builder: (context, data, child) {
              print("data: $data");

              if (data == null) {
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.yellow,
                  ),
                );
              }

              return ListView(
                children: newBuildBooks(bookData, context),
              );
            },
          ),
        );
      }),
    );
  }

  List<Widget> newBuildBooks(List<BookData> data, BuildContext context) {
    List<Widget> list = [];
    for (var i = 0; i < data.length; i++) {
      list.add(newbuildBook(data[i], i, context));
    }
    return list;
  }

  Widget newbuildBook(BookData book, int index, BuildContext context) {
    return Container(
      height: 180,
      child: Card(
        elevation: 3.0,
        child: Container(
          padding: EdgeInsets.only(left: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookDetail(bookData: book)),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/images/${book.image}",
                    width: 100,
                    height: 150,
                  ),
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
}
