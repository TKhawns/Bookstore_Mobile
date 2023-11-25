import '../base/base_event.dart';

class FailAddToCartEvent extends BaseEvent {
  String error;

  FailAddToCartEvent(this.error);
}
