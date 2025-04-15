import 'package:flutter/material.dart';
import '../models/Estate.dart';
import '../utils/EstateCard.dart';

class FavoritesPage extends StatelessWidget {
  final List<Estate> estates;

  const FavoritesPage({required this.estates});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: estates.length,
        itemBuilder: (context, index) {
          final estate = estates[index];
          return EstateCard(estate: estate);
        },
      ),
    );
  }
}
