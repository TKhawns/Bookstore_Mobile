// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, avoid_print, depend_on_referenced_packages, unused_field

import 'package:bookstore_mobile/base/base_bloc.dart';
import 'package:bookstore_mobile/base/base_event.dart';
import 'package:bookstore_mobile/module/order/order_data.dart';
import 'package:bookstore_mobile/repo/order_repository/order_repo.dart';

class OrderBloc extends BaseBloc {
  late OrderRepo _orderRepo;
  OrderBloc({required OrderRepo orderRepo}) {
    _orderRepo = orderRepo;
  }

  Stream<List<OrderData>> getOrderList(String shopName) {
    return Stream<List<OrderData>>.fromFuture(
      _orderRepo.getOrderList(shopName),
    );
  }

  Stream<List<OrderData>> getUserOrderList(String shopName) {
    return Stream<List<OrderData>>.fromFuture(
      _orderRepo.getUserOrderList(shopName),
    );
  }

  @override
  void dispatchEvent(BaseEvent event) {}

  @override
  void dispose() {
    super.dispose();
  }
}
