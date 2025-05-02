import 'package:flutter/material.dart';
import '../models/Estate.dart';
import '../widgets/category_estates_list/estate_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class FavoritesPage extends StatelessWidget {
  final List<Estate> estates;

  const FavoritesPage({required this.estates});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.p_favorites),
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
