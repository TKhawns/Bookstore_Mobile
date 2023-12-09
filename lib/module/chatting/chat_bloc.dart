// ignore_for_file: depend_on_referenced_packages, avoid_print, unnecessary_overrides
import 'package:bookstore_mobile/repo/user_repository/user_data.dart';

import '../../base/base_bloc.dart';
import '../../base/base_event.dart';
import '../../repo/user_repository/user_repo.dart';

class ChatBloc extends BaseBloc {
  final UserRepo _userRepo;

  ChatBloc({required UserRepo userRepo}) : _userRepo = userRepo;

  Stream<List<UserData>> getUserChat(String customerId) {
    return Stream<List<UserData>>.fromFuture(
      _userRepo.getUserChat(customerId),
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
