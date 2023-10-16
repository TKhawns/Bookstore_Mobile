import 'package:bookstore_mobile/repo/book_repository/book_data.dart';

import '../base/base_event.dart';
import '../repo/order_repository/book_order.dart';

class AddToCartEvent extends BaseEvent {
  BookOrder bookData;

  AddToCartEvent(this.bookData);
}
