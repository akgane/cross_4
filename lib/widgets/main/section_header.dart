import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAllPressed;

  const SectionHeader({required this.title, required this.onSeeAllPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          // style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          style: theme.textTheme.titleLarge,
        ),
        GestureDetector(
          onTap: onSeeAllPressed,
          child: Text(
            "See all",
            style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}
