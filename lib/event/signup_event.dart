import 'package:bookstore_mobile/base/base_event.dart';

class SignUpEvent extends BaseEvent {
  String displayName;
  String phone;
  String pass;

  SignUpEvent(
      {required this.displayName, required this.phone, required this.pass});
}
