import 'dart:async';

import 'package:bookstore_mobile/base/base_bloc.dart';
import 'package:bookstore_mobile/base/base_event.dart';
import 'package:bookstore_mobile/module/search/search_event.dart';
import 'package:bookstore_mobile/repo/book_repository/book_data.dart';
import 'package:bookstore_mobile/repo/book_repository/book_repo.dart';
import 'package:rxdart/rxdart.dart';

import '../../event/should_rebuild_event.dart';

class SearchBookBloc extends BaseBloc {
  final _searchText = BehaviorSubject<String>();

  final BookRepo _bookRepo;

  SearchBookBloc({
    required BookRepo bookRepo,
  }) : _bookRepo = bookRepo;

  Stream<String> get searchStream => _searchText;
  Sink<String> get searchSink => _searchText.sink;

  StreamController<List<BookData>> searchController =
      StreamController<List<BookData>>();

  final _searchSubject = BehaviorSubject<List<BookData>>();
  Stream<List<BookData>> get searchBookStream => _searchSubject.stream;
  Sink<List<BookData>> get searchBookSink => _searchSubject.sink;

  @override
  void dispose() {
    super.dispose();
    _searchText.close();
    _searchSubject.close();
  }

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case SearchEvent:
        handleSearchEvent(event);
        getBookResult(event);
        break;
    }
  }

  handleSearchEvent(event) {
    SearchEvent e = event as SearchEvent;
    _bookRepo.searchBookList(e.title).then((result) {
      processEventSink.add(ShouldRebuildEvent());
    });
  }

  Stream<List<BookData>> getBookResult(event) {
    SearchEvent e = event as SearchEvent;
    print("TESTTTTTT TITLE ${e.title}");
    return Stream<List<BookData>>.fromFuture(
      _bookRepo.searchBookList(e.title),
    );
  }
}
