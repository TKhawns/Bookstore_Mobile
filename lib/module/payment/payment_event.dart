import '../../base/base_event.dart';

class PaymentEvent extends BaseEvent {
  String customerId;
  PaymentEvent(this.customerId);
}
