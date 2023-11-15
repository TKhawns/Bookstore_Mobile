// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:bookstore_mobile/event/delete_order_event.dart';

import '../../base/base_bloc.dart';
import '../../base/base_event.dart';
import '../../event/should_rebuild_event.dart';
import '../../event/update_quantity_event.dart';
import '../../repo/book_repository/book_data.dart';
import '../../repo/order_repository/order_repo.dart';
import 'package:rxdart/rxdart.dart';

class CheckoutBloc extends BaseBloc {
  final OrderRepo _orderRepo;

  CheckoutBloc({required OrderRepo orderRepo}) : _orderRepo = orderRepo;

  final _orderSubject = BehaviorSubject<List<BookData>>();

  Stream<List<BookData>> get orderStream => _orderSubject.stream;
  Sink<List<BookData>> get orderSink => _orderSubject.sink;

  final _customerIdSubject = BehaviorSubject<String>();
  Stream<String> get customerIdStream => _customerIdSubject.stream;
  Sink<String> get customerIdSink => _customerIdSubject.sink;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case UpdateCartEvent:
        handleUpdateCart(event);
        UpdateCartEvent e = event as UpdateCartEvent;
        getOrderDetail(e.customerId);
        break;
      case DeleteOrderEvent:
        handleDeleteOrder(event);
        UpdateCartEvent e = event as UpdateCartEvent;
        getOrderDetail(e.customerId);
        break;
    }
  }

  // handleConfirmOrder(event) {
  //   _orderRepo.confirmOrder().then((isSuccess) {
  //     processEventSink.add(ShouldPopEvent());
  //   });
  // }

  handleUpdateCart(event) {
    UpdateCartEvent e = event as UpdateCartEvent;
    _orderRepo.updateOrder(e.bookData).then((isSuccess) {
      if (isSuccess) {
        processEventSink.add(ShouldRebuildEvent());
      }
    });
  }

  handleDeleteOrder(event) {
    DeleteOrderEvent e = event as DeleteOrderEvent;
    _orderRepo.deleteOrder(e.bookData).then((isSuccess) {
      if (isSuccess) {
        processEventSink.add(ShouldRebuildEvent());
      }
    });
  }

  Stream<List<BookData>> getOrderDetail(String customerId) {
    return Stream<List<BookData>>.fromFuture(
      _orderRepo.getOrderDetail(customerId),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _orderSubject.close();
  }
}
