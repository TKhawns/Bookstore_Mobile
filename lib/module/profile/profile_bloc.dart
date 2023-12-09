// ignore_for_file: depend_on_referenced_packages, avoid_print, unnecessary_overrides
import 'package:bookstore_mobile/repo/user_repository/user_data.dart';

import '../../base/base_bloc.dart';
import '../../base/base_event.dart';
import '../../repo/user_repository/user_repo.dart';

class ProfileBloc extends BaseBloc {
  final UserRepo _userRepo;

  ProfileBloc({required UserRepo userRepo}) : _userRepo = userRepo;

  // final _userSubject = BehaviorSubject<UserData>();

  // Stream<UserData> get userStream => _userSubject.stream;
  // Sink<UserData> get userSink => _userSubject.sink;

  Stream<UserData> getUserInfo(String customerId) {
    return Stream<UserData>.fromFuture(
      _userRepo.getUserInfo(customerId),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // _userSubject.close();
  }

  @override
  void dispatchEvent(BaseEvent event) {
    // TODO: implement dispatchEvent
  }
}
