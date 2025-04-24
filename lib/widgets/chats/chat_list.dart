import 'package:flutter/material.dart';

import '../../models/Users.dart';
import 'chat_tile.dart';

class ChatList extends StatelessWidget {
  final List<Chat> chats;

  const ChatList({required this.chats});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: chats.length,
      itemBuilder: (context, index) {
        return ChatTile(chat: chats[index]);
      },
    );
  }
}
