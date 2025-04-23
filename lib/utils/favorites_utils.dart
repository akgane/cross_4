import 'package:shared_preferences/shared_preferences.dart';

import '../models/Estate.dart';

class FavoriteUtils {
  static const String _favoritesKey = 'favorites';

  static Future<void> toggleFavorite(String estateId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoritesKey) ?? [];

    if (favorites.contains(estateId)) {
      favorites.remove(estateId);
    } else {
      favorites.add(estateId);
    }

    await prefs.setStringList(_favoritesKey, favorites);
  }

  static Future<bool> isFavorite(String estateId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoritesKey) ?? [];
    return favorites.contains(estateId);
  }

  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favorites') ?? [];
  }

  static Future<List<Estate>> getFavoriteEstates(List<Estate> estates) async {
    final favoriteIds = await getFavorites();
    return estates.where((estate) => favoriteIds.contains(estate.id)).toList();
  }
}