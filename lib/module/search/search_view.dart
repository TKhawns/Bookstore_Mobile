// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, sized_box_for_whitespace, avoid_print, depend_on_referenced_packages, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'dart:ui';
import 'package:bookstore_mobile/module/search/search_book_bloc.dart';
import 'package:bookstore_mobile/repo/book_repository/book_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../repo/book_repository/book_repo.dart';
import '../../repo/book_repository/book_service.dart';
import '../home/book_detail.dart';

class SearchView extends StatefulWidget {
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController searchController = TextEditingController();

  SearchBookBloc searchBloc =
      SearchBookBloc(bookRepo: BookRepo(bookService: BookService()));

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      var query = searchController.text;
      searchBloc.search(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SearchView>(
          create: (_) => SearchView(),
        ),
        Provider.value(
          value: BookService(),
        ),
        ProxyProvider<BookService, BookRepo>(
          update: (context, bookService, previous) =>
              BookRepo(bookService: bookService),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 151, 178),
          title: Container(
            margin: EdgeInsets.only(left: 10),
            height: 40,
            child: TextFormField(
              controller: searchController,
              autofocus: true,
              cursorColor: Colors.black,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 10),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 10, color: Color.fromARGB(255, 0, 151, 178)),
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: "Search Books",
                prefixIcon: Icon(Icons.search, size: 26),
              ),
            ),
          ),
        ),
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: Container(
            child: StreamBuilder<List<BookData>>(
              initialData: [],
              stream: searchBloc.searchController.stream,
              builder: (context, snapshot) {
                return ListView(
                  children: newBuildBooks(snapshot.data, context),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> newBuildBooks(List<BookData>? data, BuildContext context) {
    List<Widget> list = [];
    for (var i = 0; i < data!.length; i++) {
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
                        builder: (context) => BookDetail(
                              bookData: book,
                              customerId: "",
                            )),
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

// class BookListWidget extends StatefulWidget {
//   @override
//   State<BookListWidget> createState() => _BookListWidgetState();
// }

// class _BookListWidgetState extends State<BookListWidget> {
//   List<BookData> bookData = [];

//   handleEvent(BaseEvent event) {
//     //totalPrice = 0;
//     if (event is ShouldRebuildEvent) {
//       setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Provider<SearchBookBloc?>.value(
//       value: SearchBookBloc(bookRepo: Provider.of(context)),
//       child: Consumer<SearchBookBloc>(builder: (context, bloc, child) {
//         bloc.getBookResult(query).listen((event) {
//           for (var book in event) {
//             bookData.add(book);
//           }
//         });
//         return BlocListener<SearchBookBloc>(
//           listener: handleEvent,
//           child: StreamProvider<List<BookData>?>.value(
//             initialData: bookData,
//             value: bloc.getBookResult(query),
//             child: Consumer<List<BookData>?>(
//               builder: (context, data, child) {
//                 if (data!.isEmpty) {
//                   return const Center(
//                     child: CircularProgressIndicator(
//                       backgroundColor: Colors.yellow,
//                     ),
//                   );
//                 }

//                 return ListView(
//                   children: newBuildBooks(bookData, context),
//                 );
//               },
//             ),
//           ),
//         );
//       }),
//     );
//   }


//}
