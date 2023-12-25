// ignore_for_file: depend_on_referenced_packages, avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:async';

import 'package:bookstore_mobile/base/base_bloc.dart';
import 'package:bookstore_mobile/base/base_event.dart';
import 'package:bookstore_mobile/repo/book_repository/book_data.dart';
import 'package:bookstore_mobile/repo/book_repository/book_repo.dart';

class SearchBookBloc extends BaseBloc {
  List<BookData> bookList = [];
  final BookRepo _bookRepo;
  SearchBookBloc({
    required BookRepo bookRepo,
  }) : _bookRepo = bookRepo;

  StreamController<List<BookData>> searchController =
      StreamController<List<BookData>>();

  search(String query) {
    if (bookList.isEmpty) {
      Stream<List<BookData>>.fromFuture(
        _bookRepo.bookList(),
      ).listen((event) {
        for (var book in event) {
          bookList.add(book);
          print(book.title);
        }
      });
    }
    if (query.isEmpty) {
      searchController.sink.add(bookList);
      return;
    }
    _filter(query).then((value) {
      searchController.sink.add([]);
      Future.delayed(Duration(milliseconds: 200), () {
        searchController.sink.add(value);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.close();
  }

  @override
  void dispatchEvent(BaseEvent event) {}

  Future<List<BookData>> _filter(String query) {
    var c = Completer<List<BookData>>();
    List<BookData> result = [];
    // Stream<List<BookData>>.fromFuture(
    //   _bookRepo.searchBookList(query),
    // ).listen((event) {
    //   for (var book in event) {
    //     result.add(book);
    //     print(book.title);
    //   }
    // });
    bookList.forEach((element) {
      String title = element.title.toLowerCase();
      if (title.contains(query.toLowerCase())) {
        result.add(element);
      }
    });
    c.complete(result);
    return c.future;
  }

  // Stream<List<BookData>> getBookResult(event) {
  //   SearchEvent e = event as SearchEvent;
  //   return Stream<List<BookData>>.fromFuture(
  //     _bookRepo.searchBookList(e.title),
  //   );
  // }
}
