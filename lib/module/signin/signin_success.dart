import 'package:flutter/material.dart';
import '../../base/base_event.dart';
import '../../repo/user_data.dart';

class SignInSuccessEvent extends BaseEvent {
  final UserData userData;
  SignInSuccessEvent(this.userData);
}
