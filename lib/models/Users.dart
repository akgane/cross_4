import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String id;
  final String username;
  // final String? email;
  final String? avatarUrl;

  User({
    required this.id,
    required this.username,
    // this.email,
    this.avatarUrl
  });

  factory User.fromFirestore(DocumentSnapshot data) {
    return User(
      id: data.id,
      username: data['username'] ?? 'Unknown User',
      // email: data['email'] ?? 'email'
    );
  }

  // Map<String, dynamic> toFirestore(){
  //   return {
  //     'email': email,
  //     'username': username
  //   };
  // }
}

class Message{
  final String id;
  final String text;
  final User sender;

  Message({
    required this.id,
    required this.text,
    required this.sender
  });

  factory Message.fromFirestore(Map<String, dynamic> data, String documentId, User sender) {
    return Message(
      id: documentId,
      text: data['text'] ?? 'No message text',
      sender: sender,
    );
  }
}

class Chat{
  final String id;
  final List<User> participants;
  final List<Message> messages;

  Chat({
    required this.id,
    required this.participants,
    required this.messages
  });

  factory Chat.fromFirestore(Map<String, dynamic> data, String documentId, List<User> exampleUsers) {
    final participantIds = List<String>.from(data['participants'] ?? []);
    final participants = participantIds.map((id) => exampleUsers.firstWhere((user) => user.id == id)).toList();

    final messageData = List<Map<String, dynamic>>.from(data['messages'] ?? []);
    final messages = messageData.map((msgData) {
      final senderId = msgData['sender'];
      final sender = exampleUsers.firstWhere((user) => user.id == senderId);
      return Message.fromFirestore(msgData, msgData['id'], sender);
    }).toList();

    return Chat(
      id: documentId,
      participants: participants,
      messages: messages,
    );
  }
}