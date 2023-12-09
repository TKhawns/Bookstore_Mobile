// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, depend_on_referenced_packages, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, nullable_type_in_catch_clause, unused_local_variable, non_constant_identifier_names, prefer_final_fields

import 'dart:async';

import 'package:bookstore_mobile/repo/message_repository/message_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'mock_message_repository.dart';
import 'package:uuid/uuid.dart';
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatShopPage extends StatefulWidget {
  final String customerId;
  final String shopName;
  final String shopImage;
  ChatShopPage(
      {required this.customerId,
      required this.shopName,
      required this.shopImage});

  @override
  State<ChatShopPage> createState() => _ChatShopPageState();
}

class _ChatShopPageState extends State<ChatShopPage> {
  late MockMessageRepository _repository = MockMessageRepository(
      messageService: MessageService(),
      customerId: widget.customerId,
      shopName: widget.shopName);
  MessageService _messageService = MessageService();
  final List<types.Message> _messages = [];
  //String user_id = "3af298e0-e126-4ce0-b957-b637869b2da3";
  late types.User _user = types.User(id: widget.customerId);

  final String roomId = "test_room_id";
  Future<void> initMessages() async {
    await _repository.init();
    List<types.Message> messages =
        await _repository.fetchOlderMessage(roomId, 20);
    _messages.addAll(messages);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }

  Future<void> onEndReached() async {
    List<types.Message> messages =
        await _repository.fetchOlderMessage(roomId, 1, _messages.last);
    setState(() {
      _messages.addAll(messages);
    });
  }

  @override
  void initState() {
    initMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              height: 50,
              child: CircleAvatar(
                radius: 35, // Image radius
                backgroundImage: NetworkImage(widget.shopImage),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        widget.shopName,
                        style: GoogleFonts.inter(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 3),
                      child: Icon(
                        Icons.verified_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    "Thường trả lời ngay",
                    style: GoogleFonts.inter(
                        color: Colors.grey[300],
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.more_horiz_outlined,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Chat(
        theme: const DefaultChatTheme(
            messageInsetsHorizontal: 20,
            messageInsetsVertical: 8,
            inputMargin: EdgeInsets.only(bottom: 20, right: 10, left: 10),
            inputPadding: EdgeInsets.only(top: 12, bottom: 12),
            inputTextStyle: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w500,
            ),
            inputContainerDecoration: BoxDecoration(
              color: Color.fromARGB(255, 0, 151, 178),
              borderRadius: BorderRadius.all(
                Radius.circular(35),
              ),
            ),
            messageBorderRadius: 35,
            primaryColor: Color.fromARGB(255, 0, 151, 178),
            inputTextColor: Colors.white,
            inputTextCursorColor: Colors.white,
            inputBackgroundColor: Colors.white),
        messages: _messages,
        onSendPressed: (types.PartialText message) {
          setState(() {
            _messages.insert(
                0,
                types.TextMessage(
                  author: _user,
                  id: Uuid().v4(),
                  text: message.text,
                ));
            addMessage(widget.customerId, DateTime.now().millisecondsSinceEpoch,
                message.text, _messages[0].id.toString(), widget.shopName);
          });
        },
        onEndReached: onEndReached,
        user: _user,
        showUserNames: true,
        showUserAvatars: true,
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<bool> addMessage(String customerId, int createAt, String text,
      String mess_id, String shopName) async {
    var c = Completer<bool>();
    try {
      var response = await _messageService.addMessage(
          customerId, createAt, text, mess_id, shopName);
      c.complete(true);
    } on DioException {
      c.completeError('Lỗi add message');
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }
}
