import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String username;
  final String avatarUrl;

  const ProfilePage({required this.username, required this.avatarUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.deepOrangeAccent,
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
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              "Hello User ! \n"
              "Its your profile page",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
