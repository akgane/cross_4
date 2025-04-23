import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget{
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const CategoryCard({
    required this.title,
    required this.icon,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: theme.cardColor
            ),

            padding: const EdgeInsets.all(12),

            child: Icon(
              icon,
              color: theme.iconTheme.color
            ),
          ),

          SizedBox(height: 4),

          Text(
            title,
            style: theme.textTheme.bodyMedium
          )
        ],
      )
    );
  }
}