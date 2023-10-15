import 'package:bookstore_mobile/repo/order_repository/book_order.dart';

import '../../base/base_bloc.dart';
import '../../base/base_event.dart';
import '../../repo/order_repository/order_repo.dart';
import '../../widget/order.dart';

class CheckoutBloc extends BaseBloc {
  final OrderRepo _orderRepo;

  CheckoutBloc({
    required OrderRepo orderRepo,
  }) : _orderRepo = orderRepo;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      // case UpdateCartEvent:
      //   handleUpdateCart(event);
      //   break;
      // case ConfirmOrderEvent:
      //   handleConfirmOrder(event);
      //   break;
    }
  }

  // handleConfirmOrder(event) {
  //   _orderRepo.confirmOrder().then((isSuccess) {
  //     processEventSink.add(ShouldPopEvent());
  //   });
  // }

  // handleUpdateCart(event) {
  //   UpdateCartEvent e = event as UpdateCartEvent;
  //   _orderRepo.updateOrder(e.product).then((isSuccess) {
  //     if (isSuccess) {
  //       processEventSink.add(ShouldRebuildEvent());
  //     }
  //   });
  // }

  Stream<List<BookOrder>> getOrderDetail() {
    return Stream<List<BookOrder>>.fromFuture(
      _orderRepo.getOrderDetail(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
