// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'package:dio/dio.dart';
import '../../database/dio_get.dart';

class MessageService {
  Future<Response> getMessageList(String customerId, String shopName) {
    return BookClient.instance.dio.post('/chat/message', data: {
      'customerId': customerId,
      'shopName': shopName,
    });
  }

  Future<Response> addMessage(String customerId, int createAt, String text,
      String mess_id, String shopName) {
    return BookClient.instance.dio.post('/chat/add', data: {
      'user_id': customerId,
      'status': 'sent',
      'create_at': createAt,
      'mess_text': text,
      'mess_type': 'text',
      'mess_id': mess_id,
      'shopName': shopName,
    });
  }
}
