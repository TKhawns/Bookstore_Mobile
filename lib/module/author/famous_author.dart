// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, depend_on_referenced_packages, sized_box_for_whitespace

import 'dart:ui';

import 'package:bookstore_mobile/repo/author_repository/author_repo.dart';
import 'package:bookstore_mobile/repo/author_repository/author_service.dart';
import 'package:bookstore_mobile/repo/order_repository/order_repo.dart';
import 'package:bookstore_mobile/repo/order_repository/order_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../repo/author_repository/author_data.dart';
import '../../repo/book_repository/book_repo.dart';
import '../../repo/book_repository/book_service.dart';
import '../../repo/user_repository/user_repo.dart';
import '../../repo/user_repository/user_service.dart';
import '../home/home_bloc.dart';
import 'author_profile.dart';
import 'package:google_fonts/google_fonts.dart';

class FamousAuthor extends StatefulWidget {
  const FamousAuthor({super.key});

  @override
  State<FamousAuthor> createState() => _FamoousAuthorState();
}

class _FamoousAuthorState extends State<FamousAuthor> {
  List<AuthorData> authorData = [];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FamousAuthor>(
          create: (_) => FamousAuthor(),
        ),
        Provider.value(
          value: UserService(),
        ),
        ProxyProvider<UserService, UserRepo>(
          update: (context, userService, previous) =>
              UserRepo(userService: userService),
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
        Provider.value(
          value: OrderService(),
        ),
        ProxyProvider<OrderService, OrderRepo>(
          update: (context, orderService, previous) =>
              OrderRepo(orderService: orderService),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Famous Authors",
            style: GoogleFonts.inter(color: Colors.white, fontSize: 25),
          ),
        ),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: AuthorListWidget(),
        ),
      ),
    );
  }
}

class AuthorListWidget extends StatelessWidget {
  List<AuthorData> authorData = [];

  @override
  Widget build(BuildContext context) {
    return Provider<HomeBloc?>.value(
      value: HomeBloc.getInstance(
        bookRepo: Provider.of(context),
        orderRepo: Provider.of(context),
        authorRepo: Provider.of(context),
        userRepo: Provider.of(context),
      ),
      child: Consumer<HomeBloc>(builder: (context, bloc, child) {
        bloc.getAuthorList().listen((event) {
          for (var author in event) {
            authorData.add(author);
          }
        });
        return StreamProvider<List<AuthorData>?>.value(
          initialData: authorData,
          value: bloc.getAuthorList(),
          child: Consumer<List<AuthorData>?>(
            builder: (context, data, child) {
              if (data!.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.yellow,
                  ),
                );
              }

              return ListView(
                children: buildListAuthors(authorData, context),
              );
            },
          ),
        );
      }),
    );
  }

  List<Widget> buildListAuthors(
      List<AuthorData> authors, BuildContext context) {
    List<Widget> list = [];
    for (var i = 0; i < authors.length; i++) {
      list.add(buildListAuthor(authors[i], context));
    }
    return list;
  }

  Widget buildListAuthor(AuthorData author, BuildContext context) {
    return Container(
      height: 140,
      child: Card(
        elevation: 3.0,
        child: Container(
          padding: EdgeInsets.only(left: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  author.image,
                  width: 120,
                  height: 120,
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
                      author.full_name,
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, left: 15),
                    child: Text(
                      "${author.number_books} books",
                      style: GoogleFonts.inter(
                          color: Colors.blue,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 90),
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
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AuthorProfile(author: author)),
                              );
                            },
                            child: Text(
                              'Learn more',
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
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
