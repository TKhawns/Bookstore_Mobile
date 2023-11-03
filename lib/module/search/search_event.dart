import 'package:bookstore_mobile/base/base_event.dart';

class SearchEvent extends BaseEvent {
  String title;
  SearchEvent({required this.title});
}
