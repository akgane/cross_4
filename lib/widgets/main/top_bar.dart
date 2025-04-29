import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:math';

import '../../pages/profile_page.dart';

class TopBar extends StatefulWidget {
  final String username;
  final String avatarUrl;

  const TopBar({
    required this.username,
    this.avatarUrl = 'https://randomuser.me/api/portraits/men/1.jpg',
    Key? key,
  }) : super(key: key);

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> with SingleTickerProviderStateMixin {
  bool _isNotificationActive = false;
  late AnimationController _controller;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _shakeAnimation = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticIn,
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onNotificationPressed() {
    setState(() {
      _isNotificationActive = !_isNotificationActive;
    });
    _controller.forward();
  }

  void _openProfilePage() {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 600),
        pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
          opacity: animation,
          child: ProfilePage(
            username: widget.username,
            avatarUrl: widget.avatarUrl,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: _openProfilePage,
          child: Hero(
            tag: 'profile-avatar',
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.avatarUrl),
              radius: 20,
            ),
          ),
        ),

        SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.m_welcome_back,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
              Text(
                widget.username,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ],
          ),
        ),

        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            double offset = sin(_shakeAnimation.value * pi) * 4;
            return Transform.translate(
              offset: Offset(offset, 0),
              child: IconButton(
                icon: Icon(
                  _isNotificationActive ? Icons.notifications_active : Icons.notifications_none,
                  color: _isNotificationActive
                      ? Colors.green
                      : Theme.of(context).iconTheme.color,
                ),
                onPressed: _onNotificationPressed,
              ),
            );
          },
        ),
      ],
    );
  }
}