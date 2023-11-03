// ignore_for_file: depend_on_referenced_packages

import 'package:bookstore_mobile/event/delete_order_event.dart';
import 'package:bookstore_mobile/repo/shop_repository/shop_data.dart';
import 'package:bookstore_mobile/repo/shop_repository/shop_repo.dart';

import '../../base/base_bloc.dart';
import '../../base/base_event.dart';
import '../../event/update_quantity_event.dart';
import '../../repo/book_repository/book_data.dart';
import 'package:rxdart/rxdart.dart';

class ShopBloc extends BaseBloc {
  final ShopRepo _shopRepo;

  ShopBloc({
    required ShopRepo shopRepo,
  }) : _shopRepo = shopRepo;

  final _shopSubject = BehaviorSubject<List<BookData>>();

  Stream<List<BookData>> get shopStream => _shopSubject.stream;
  Sink<List<BookData>> get shopSink => _shopSubject.sink;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case UpdateCartEvent:
        break;
      case DeleteOrderEvent:
        break;
    }
  }

  Stream<ShopData> getShopInfo(String shopname) {
    return Stream<ShopData>.fromFuture(
      _shopRepo.getShopInfo(shopname),
    );
  }

  Stream<List<BookData>> getBookDetail(String shopname) {
    return Stream<List<BookData>>.fromFuture(
      _shopRepo.getBookDetail(shopname),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _shopSubject.close();
  }
}
