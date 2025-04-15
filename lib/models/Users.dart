class User{
  final String id;
  final String username;
  final String? avatarUrl;

  User({
    required this.id,
    required this.username,
    this.avatarUrl
  });
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
}