import 'dart:async';

import 'package:bookstore_mobile/base/base_bloc.dart';
import 'package:bookstore_mobile/base/base_event.dart';
import 'package:bookstore_mobile/repo/book_repository/book_data.dart';
import 'package:rxdart/rxdart.dart';

import '../home/home_bloc.dart';

class SearchBookBloc extends BaseBloc {
  final _searchText = BehaviorSubject<String>();

  Stream<String> get searchStream => _searchText;
  Sink<String> get searchSink => _searchText.sink;

  StreamController<List<BookData>> searchController =
      StreamController<List<BookData>>();


  void dispose() {
    super.dispose();
    _searchText.close();
  }

  @override
  void dispatchEvent(BaseEvent event) {
    // TODO: implement dispatchEvent
  }
}
