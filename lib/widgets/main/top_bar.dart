import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TopBar extends StatelessWidget{
  final String username;
  final String avatarUrl;

  const TopBar({
        required this.username,
        this.avatarUrl = 'https://randomuser.me/api/portraits/men/1.jpg'
      });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(avatarUrl),
        ),

        SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  AppLocalizations.of(context)!.m_welcome_back,
                  style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyMedium?.color)),
              Text(
                  username,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyMedium?.color)),
            ],
          )
        ),

        IconButton(
          icon: Icon(Icons.notifications_none),
          color: Theme.of(context).iconTheme.color,
          onPressed: (){},
        ),
      ],
    );
  }
}