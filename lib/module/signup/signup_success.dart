import 'package:flutter/material.dart';
import '../../base/base_event.dart';
import '../../repo/user_data.dart';

class SignUpSuccessEvent extends BaseEvent {
  final UserData userData;
  SignUpSuccessEvent(this.userData);
}
