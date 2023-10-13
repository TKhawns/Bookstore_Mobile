import 'package:bookstore_mobile/base/base_event.dart';
import 'package:bookstore_mobile/repo/author_repository/author_data.dart';
import 'package:bookstore_mobile/repo/book_repository/book_data.dart';
import 'package:bookstore_mobile/repo/book_repository/book_repo.dart';

import '../../base/base_bloc.dart';
import '../../repo/author_repository/author_repo.dart';

class HomeBloc extends BaseBloc {
  final BookRepo _bookRepo;
  final AuthorRepo _authorRepo;
  static HomeBloc? _instance;

  static HomeBloc? getInstance({
    required BookRepo bookRepo,
    required AuthorRepo authorRepo,
  }) {
    _instance ??= HomeBloc._internal(
      bookRepo: bookRepo,
      authorRepo: authorRepo,
    );

    return _instance;
  }

  HomeBloc._internal(
      {required BookRepo bookRepo, required AuthorRepo authorRepo})
      : _bookRepo = bookRepo,
        _authorRepo = authorRepo;

  Stream<List<BookData>> getBookList() {
    return Stream<List<BookData>>.fromFuture(
      _bookRepo.bookList(),
    );
  }

  Stream<List<AuthorData>> getAuthorList() {
    return Stream<List<AuthorData>>.fromFuture(
      _authorRepo.authorList(),
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
