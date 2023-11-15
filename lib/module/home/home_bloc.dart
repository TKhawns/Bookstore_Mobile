// ignore_for_file: unused_field, prefer_final_fields, depend_on_referenced_packages

import 'package:bookstore_mobile/base/base_event.dart';
import 'package:bookstore_mobile/repo/author_repository/author_data.dart';
import 'package:bookstore_mobile/repo/book_repository/book_data.dart';
import 'package:bookstore_mobile/repo/book_repository/book_repo.dart';
import 'package:bookstore_mobile/repo/order_repository/order_repo.dart';

import '../../base/base_bloc.dart';
import '../../event/add_to_cart_event.dart';
import '../../repo/author_repository/author_repo.dart';
import '../../repo/user_repository/user_repo.dart';
import '../../widget/shopping_cart.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BaseBloc {
  final BookRepo _bookRepo;
  final AuthorRepo _authorRepo;
  final OrderRepo _orderRepo;
  final UserRepo _userRepo;
  static HomeBloc? _instance;

  var _shoppingCart = ShoppingCart(total: -1);

  static HomeBloc? getInstance({
    required BookRepo bookRepo,
    required AuthorRepo authorRepo,
    required OrderRepo orderRepo,
    required UserRepo userRepo,
  }) {
    _instance ??= HomeBloc._internal(
      bookRepo: bookRepo,
      authorRepo: authorRepo,
      orderRepo: orderRepo,
      userRepo: userRepo,
    );

    return _instance;
  }

  HomeBloc._internal(
      {required BookRepo bookRepo,
      required AuthorRepo authorRepo,
      required OrderRepo orderRepo,
      required UserRepo userRepo})
      : _bookRepo = bookRepo,
        _authorRepo = authorRepo,
        _orderRepo = orderRepo,
        _userRepo = userRepo;

  Stream<List<BookData>> getBookList() {
    return Stream<List<BookData>>.fromFuture(
      _bookRepo.bookList(),
    );
  }

  Stream<List<BookData>> getSearchResult(String title) {
    return Stream<List<BookData>>.fromFuture(
      _bookRepo.searchBookList(title),
    );
  }

  Stream<List<AuthorData>> getAuthorList() {
    return Stream<List<AuthorData>>.fromFuture(
      _authorRepo.authorList(),
    );
  }

  final _shoppingCardSubject = BehaviorSubject<ShoppingCart>();
  Stream<ShoppingCart> get shoppingCartStream => _shoppingCardSubject.stream;
  Sink<ShoppingCart> get shoppingCartSink => _shoppingCardSubject.sink;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case AddToCartEvent:
        handleAddToCart(event);
        getShoppingCartInfo();
        break;
    }
  }

  handleAddToCart(event) {
    AddToCartEvent addToCartEvent = event as AddToCartEvent;
    _orderRepo.addToCart(addToCartEvent.bookData).then((shoppingCart) {
      shoppingCartSink.add(shoppingCart);
    });
  }

  getShoppingCartInfo() {
    Stream<ShoppingCart>.fromFuture(_orderRepo.getShoppingCartInfo()).listen(
        (shoppingCart) {
      _shoppingCart = shoppingCart;
      shoppingCartSink.add(shoppingCart);
    }, onError: (err) {
      _shoppingCardSubject.addError(err);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _shoppingCardSubject.close();
  }
}
