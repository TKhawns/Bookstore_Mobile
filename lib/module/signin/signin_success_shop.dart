import '../../base/base_event.dart';
import '../../repo/user_repository/user_data.dart';

class ShopSignInSuccessEvent extends BaseEvent {
  final UserData userData;
  ShopSignInSuccessEvent(this.userData);
}
