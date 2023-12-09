// ignore_for_file: unnecessary_import, depend_on_referenced_packages, prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors_in_immutables
import 'package:bookstore_mobile/module/chatting/chat_bloc.dart';
import 'package:bookstore_mobile/module/chatting/chat_widget.dart';
import 'package:bookstore_mobile/repo/user_repository/user_data.dart';
import 'package:bookstore_mobile/repo/user_repository/user_repo.dart';
import 'package:bookstore_mobile/repo/user_repository/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'package:provider/provider.dart';

class ShopChatWidget extends StatelessWidget {
  String customerId;
  ShopChatWidget({required this.customerId});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ShopChatWidget>(
          create: (_) => ShopChatWidget(
            customerId: "",
          ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Messages",
            style: GoogleFonts.inter(fontSize: 21, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: MessageListWidget(
          customerId: customerId,
        ),
      ),
    );
  }
}

class MessageListWidget extends StatefulWidget {
  final String customerId;
  MessageListWidget({required this.customerId});

  @override
  State<MessageListWidget> createState() => _MessageListWidget();
}

class _MessageListWidget extends State<MessageListWidget> {
  List<UserData> bookData = [];
  @override
  Widget build(BuildContext context) {
    return Provider<ChatBloc?>.value(
      value: ChatBloc(userRepo: UserRepo(userService: UserService())),
      child: Consumer<ChatBloc>(builder: (context, bloc, child) {
        print(widget.customerId);
        bloc.getUserChat(widget.customerId).listen((event) {
          for (var book in event) {
            bookData.add(book);
          }
        });
        return StreamProvider<List<UserData>?>.value(
          initialData: bookData,
          value: bloc.getUserChat(widget.customerId),
          child: Consumer<List<UserData>?>(
            builder: (context, data, child) {
              if (data!.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.yellow,
                  ),
                );
              }

              return ListView(
                children: buildMessages(bookData, context, widget.customerId),
              );
            },
          ),
        );
      }),
    );
  }
}

List<Widget> buildMessages(
    List<UserData> data, BuildContext context, String customerId) {
  List<Widget> list = [];
  for (var i = 0; i < data.length; i++) {
    list.add(buildMessage(data[i], i, context, customerId));
  }
  return list;
}

Widget buildMessage(
    UserData message, int index, BuildContext context, String customerId) {
  return Column(
    children: [
      SizedBox(
        height: 100,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[50],
            minimumSize: Size(200, 70),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatShopPage(
                      customerId: customerId,
                      shopName: message.displayName,
                      shopImage: message.avatar)),
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, right: 15),
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(message.avatar),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    message.displayName,
                    style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Tap to open message",
                    style: GoogleFonts.inter(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      Container(
        height: 3,
        color: Colors.grey[300],
      ),
    ],
  );
}
