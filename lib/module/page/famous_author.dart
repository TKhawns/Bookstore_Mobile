import 'dart:ui';

import 'package:bookstore_mobile/module/page/author_profile.dart';
import 'package:bookstore_mobile/widget/author_list.dart';
import 'package:bookstore_mobile/widget/book_list.dart';
import 'package:flutter/material.dart';

import '../home/book_detail.dart';

class FamousAuthor extends StatefulWidget {
  const FamousAuthor({super.key});

  @override
  State<FamousAuthor> createState() => _FamousAuthorState();
}

class _FamousAuthorState extends State<FamousAuthor> {
  List<Author> authors = getAuthorList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Famous Authors",
          style: TextStyle(color: Colors.white, fontSize: 25),
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
        child: ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: buildListBooks(),
        ),
      ),
    );
  }

  List<Widget> buildListBooks() {
    List<Widget> list = [];
    for (var i = 0; i < authors.length; i++) {
      list.add(buildListBook(authors[i]));
    }
    return list;
  }

  Widget buildListBook(Author author) {
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
                child: Image.asset(
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
                    margin: EdgeInsets.only(top: 15, left: 30, right: 10),
                    child: Text(
                      author.fullName,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, left: 30),
                    child: Text(
                      "${author.books} books",
                      style: TextStyle(color: Colors.blue, fontSize: 17),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
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
