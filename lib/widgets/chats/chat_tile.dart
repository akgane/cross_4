import 'package:flutter/material.dart';

import '../../misc/app_routes.dart';
import '../../models/Users.dart';
import '../../misc/route_generator.dart';

class ChatTile extends StatelessWidget {
  final Chat chat;

  const ChatTile({required this.chat});

  @override
  Widget build(BuildContext context) {
    final lastMessage = chat.messages.isNotEmpty ? chat.messages.last : null;
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.chatDetails,
          arguments: {'chat': chat},
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: theme.cardColor.withOpacity(0.1),
        ),
        child: Row(
          children: [
            const SizedBox(width: 12),
            ChatAvatar(url: chat.participants.first.avatarUrl),
            const SizedBox(width: 12),
            Expanded(
              child: ChatInfo(
                username: chat.participants[1].username,
                lastMessage: lastMessage?.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatAvatar extends StatelessWidget {
  final String? url;

  const ChatAvatar({this.url});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(backgroundImage: NetworkImage(url ?? ''));
  }
}

class ChatInfo extends StatelessWidget {
  final String username;
  final String? lastMessage;

  const ChatInfo({required this.username, this.lastMessage});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(username, style: theme.textTheme.titleMedium),
        const SizedBox(height: 4),
        if (lastMessage != null)
          Text(
            lastMessage!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall,
          ),
      ],
    );
  }
}
