import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental/misc/app_routes.dart';

import '../services/auth_service.dart';

class ProfilePage extends StatelessWidget {
  final String username;
  final String avatarUrl;

  const ProfilePage({required this.username, required this.avatarUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'profile-avatar',
              child: CircleAvatar(
                backgroundImage: NetworkImage(avatarUrl),
                radius: 100,
              ),
            ),
            SizedBox(height: 24),
            Text(
              username,
              style: theme.textTheme.titleLarge,
            ),
            SizedBox(height: 12),
            Text(
              "Hello User ! \n"
              "Its your profile page",
              style: theme.textTheme.bodyMedium,
            ),
            SizedBox(height: 12,),
            IconButton(
              icon: Icon(Icons.logout, color: Theme.of(context).iconTheme.color),
              onPressed: () {
                Provider.of<AuthService>(context, listen: false).signOut();

                Navigator.pushNamed(context, AppRoutes.auth);
              },
            )
          ],
        ),
      ),
    );
  }
}
