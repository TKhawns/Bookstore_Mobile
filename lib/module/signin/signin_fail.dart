import '../../base/base_event.dart';

class SignInFailEvent extends BaseEvent {
  final String errorMessage;
  SignInFailEvent(this.errorMessage);
}
