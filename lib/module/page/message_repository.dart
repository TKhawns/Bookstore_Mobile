// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

abstract class MessageRepository {
  Future<List<types.Message>> fetchOlderMessage(String roomId, int limit,
      [types.Message? startMessage]);

  Future<List<types.Message>> fetchNewerMessage(String roomId, int limit,
      [types.Message? startMessage]);
}
