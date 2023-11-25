// ignore_for_file: prefer_const_declarations, depend_on_referenced_packages, avoid_print, prefer_typing_uninitialized_variables
import 'package:bookstore_mobile/repo/message_repository/message_data.dart';
import 'package:bookstore_mobile/repo/message_repository/message_service.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'message_repository.dart';

class MockMessageRepository implements MessageRepository {
  RxBool isLoading = false.obs;
  List<types.Message> remoteMessages = [];

  final MessageService _messageService;
  final customerId;
  final shopName;
  MockMessageRepository(
      {required MessageService messageService,
      required this.customerId,
      required this.shopName})
      : _messageService = messageService;

  Future<void> init() async {
    isLoading.value = true;
    remoteMessages = await _loadMessages();
    List<types.Message> messages = [];
    remoteMessages.addAll(messages);
    isLoading.value = false;
  }

  @override
  Future<List<types.Message>> fetchNewerMessage(String roomId, int limit,
      [types.Message? startMessage]) async {
    if (startMessage == null) {
      return remoteMessages.take(limit).toList();
    } else {
      List<types.Message> messages = remoteMessages.reversed
          .skipWhile((value) => value.id != startMessage.id)
          .take(limit + 1)
          .toList()
          .reversed
          .toList();
      return messages.isEmpty ? [] : messages.skip(1).toList();
    }
  }

  @override
  Future<List<types.Message>> fetchOlderMessage(String roomId, int limit,
      [types.Message? startMessage]) async {
    if (startMessage == null) {
      return remoteMessages.take(limit).toList();
    } else {
      List<types.Message> messages = remoteMessages.skipWhile((value) {
        final bool b = value.id != startMessage.id;
        return b;
      }).toList();

      messages = messages.take(limit + 1).toList();

      return messages.isEmpty ? [] : messages.skip(1).toList();
    }
  }

  Future<List<types.Message>> _loadMessages() async {
    final result = await _messageService.getMessageList(customerId, shopName);
    final List<types.Message> messages = (result.data['data'] as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();
    return messages;
  }

  static List<MessageData> parseMessageDataList(map) {
    var list = map["data"] as List;
    print(list);
    return list.map((message) => MessageData.fromJson(message)).toList();
  }
}
