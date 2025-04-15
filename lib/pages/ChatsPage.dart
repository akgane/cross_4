import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental/data/data.dart';

import '../models/Users.dart';
import 'ChatDetailsPage.dart';

class ChatsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage>{
  late List<Chat> chats;

  @override
  void initState(){
    super.initState();
    chats = exampleChats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: chats.length,
        itemBuilder: (context, index){
          final chat = chats[index];
          return ChatTile(chat: chat);
        },
      )
    );
  }
}

class ChatTile extends StatelessWidget{
  final Chat chat;

  const ChatTile({required this.chat});

  @override
  Widget build(BuildContext context) {
    final lastMessage = chat.messages.isNotEmpty ? chat.messages.last : null;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailsPage(chat: chat),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[300]
        ),
        child: Row(
          children: [
            SizedBox(width: 12),
            CircleAvatar(
              backgroundImage: NetworkImage(chat.participants.first.avatarUrl ?? ''),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.participants[1].username,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  if (lastMessage != null)
                    Text(
                      lastMessage.text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}