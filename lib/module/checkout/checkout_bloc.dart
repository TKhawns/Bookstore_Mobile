// ignore_for_file: depend_on_referenced_packages, avoid_print, unused_local_variable

import 'package:bookstore_mobile/event/delete_order_event.dart';
import 'package:bookstore_mobile/module/checkout/payment_event.dart';
import 'package:bookstore_mobile/module/confirm/confirm_event.dart';

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
        UpdateCartEvent e = event as UpdateCartEvent;
        handleUpdateCart(e);
        getOrderDetail(e.customerId);
        break;
      case DeleteOrderEvent:
        DeleteOrderEvent e = event as DeleteOrderEvent;
        handleDeleteOrder(event);
        getOrderDetail(e.customerId);
        break;
      case ConfirmEvent:
        handleConfirmCart(event);
      case PaymentEvent:
        handleSetPaymentStauts(event);
    }
  }

  // handleConfirmOrder(event) {
  //   _orderRepo.confirmOrder().then((isSuccess) {
  //     processEventSink.add(ShouldPopEvent());
  //   });
  // }

  handleUpdateCart(event) {
    UpdateCartEvent e = event as UpdateCartEvent;
    _orderRepo.updateOrder(e.bookData, e.customerId).then((isSuccess) {
      if (isSuccess) {
        processEventSink.add(ShouldRebuildEvent());
      }
    });
  }

  handleConfirmCart(event) {
    ConfirmEvent e = event as ConfirmEvent;
    _orderRepo.confirmOrder().then((isSuccess) {
      if (isSuccess) {
        print('Confirm success');
      }
    });
  }

  handleSetPaymentStauts(event) {
    PaymentEvent e = event as PaymentEvent;
    _orderRepo.setPaymentStatus(e.customerId).then((isSuccess) {
      if (isSuccess) {
        print('Set payment status success');
      }
    });
  }

  handleDeleteOrder(event) {
    DeleteOrderEvent e = event as DeleteOrderEvent;
    _orderRepo.deleteOrder(e.bookData, e.customerId).then((isSuccess) {
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
