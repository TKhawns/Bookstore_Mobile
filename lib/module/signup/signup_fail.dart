import '../../base/base_event.dart';

class SignUpFailEvent extends BaseEvent {
  final String errorMessage;
  SignUpFailEvent(this.errorMessage);
}
