import 'package:bookstore_mobile/repo/book_repository/book_data.dart';
import '../base/base_event.dart';

class AddToCartEvent extends BaseEvent {
  BookData bookData;

  AddToCartEvent(this.bookData);
}
