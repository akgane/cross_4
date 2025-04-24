import 'package:flutter/material.dart';
import '../models/Users.dart';
import '../widgets/chat_details/message_bubble.dart';
import '../widgets/chat_details/message_input.dart';

class ChatDetailsPage extends StatelessWidget {
  final Chat chat;

  const ChatDetailsPage({required this.chat});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          chat.participants[1].username,
          style: theme.textTheme.titleMedium?.copyWith(color: theme.appBarTheme.foregroundColor),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chat.messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(message: chat.messages[index]);
              },
            ),
          ),
          MessageInput(
            onSendMessage: (text) {
              print('Message sent: $text');
            },
          ),
        ],
      ),
    );
  }
}
