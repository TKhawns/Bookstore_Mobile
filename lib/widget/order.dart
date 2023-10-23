import '../repo/book_repository/book_data.dart';

class Order {
  List<BookData> items;

  Order({required this.items});

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        items: parseOrderList(json),
      );
  static List<BookData> parseOrderList(map) {
    var list = map['data'] as List;
    return list.map((product) => BookData.fromJson(product)).toList();
  }
}
