import '../../base/base_bloc.dart';
import '../../base/base_event.dart';
import '../../event/add_to_cart_event.dart';
import '../../repo/book_repository/book_data.dart';
import '../../repo/order_repository/order_repo.dart';

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

  Stream<List<BookData>> getOrderDetail() {
    return Stream<List<BookData>>.fromFuture(
      _orderRepo.getOrderDetail(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
