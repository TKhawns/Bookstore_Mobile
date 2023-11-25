import 'package:bookstore_mobile/repo/book_repository/book_data.dart';
import '../base/base_event.dart';

class DeleteOrderEvent extends BaseEvent {
  BookData bookData;
  String customerId;

  DeleteOrderEvent(this.bookData, this.customerId);
}
