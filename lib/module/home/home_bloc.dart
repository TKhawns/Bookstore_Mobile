import 'package:bookstore_mobile/base/base_event.dart';
import 'package:bookstore_mobile/repo/book_repository/book_data.dart';
import 'package:bookstore_mobile/repo/book_repository/book_repo.dart';

import '../../base/base_bloc.dart';

class HomeBloc extends BaseBloc {
  final BookRepo _bookRepo;
  static HomeBloc? _instance;

  static HomeBloc? getInstance({
    required BookRepo bookRepo,
  }) {
    _instance ??= HomeBloc._internal(
      bookRepo: bookRepo,
    );

    return _instance;
  }

  HomeBloc._internal({required BookRepo bookRepo}) : _bookRepo = bookRepo;

  Stream<List<BookData>> getBookList() {
    return Stream<List<BookData>>.fromFuture(
      _bookRepo.bookList(),
    );
  }
  @override
  void dispose() {
    super.dispose();
    print("homepage close");
  }

  @override
  void dispatchEvent(BaseEvent event) {
    // TODO: implement dispatchEvent
  }
}
