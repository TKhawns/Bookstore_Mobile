import 'package:bookstore_mobile/repo/book_repository/book_order.dart';

class Order {
  List<BookOrder> items;

  Order({required this.items});

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        items: parseOrderList(json),
      );
  static List<BookOrder> parseOrderList(map) {
    var list = map['data'] as List;
    return list.map((product) => BookOrder.fromJson(product)).toList();
  }
}
