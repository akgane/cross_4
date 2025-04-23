import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/Estate.dart';

class EstateCard extends StatelessWidget{
  final Estate estate;
  final VoidCallback onTap;

  const EstateCard({
    required this.estate,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
              blurRadius: 6
            )
          ]
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                estate.imageUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover
              )
            ),

            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    estate.title,
                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)
                  ),

                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14,
                        color: Colors.grey //!TODO: Change to theme color
                      ),

                      SizedBox(width: 4),

                      Expanded(
                        child: Text(
                          estate.address,
                          style: theme.textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        )
                      )
                    ]
                  ),

                  SizedBox(height: 4),

                  Text(
                    '\$${estate.price}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, color: theme.colorScheme.primary
                    )
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }
}