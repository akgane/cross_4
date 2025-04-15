import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/Users.dart';

class ChatDetailsPage extends StatelessWidget {
  final Chat chat;

  const ChatDetailsPage({required this.chat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chat.participants[1].username),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: false,
              itemCount: chat.messages.length,
              itemBuilder: (context, index) {
                final message = chat.messages[index];
                return MessageBubble(message: message);
              },
            ),
          ),
          MessageInput(onSendMessage: (text) {
            print('Message sent: $text');
          }),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isMe = message.sender.id == '1';
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? Colors.orange[100] : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(message.text),
      ),
    );
  }
}

class MessageInput extends StatelessWidget {
  final Function(String) onSendMessage;

  const MessageInput({required this.onSendMessage});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return SafeArea(
      child: Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey[200],
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                onSendMessage(_controller.text);
                _controller.clear();
              }
            },
          ),
        ],
      ),
      )
    );
  }
}