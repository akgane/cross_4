import 'package:flutter/material.dart';
import 'package:rental/pages/AllEstatesPage.dart';
import 'package:rental/pages/EstateDetailsPage.dart';
import 'package:rental/pages/FavoritesPage.dart';
import 'package:rental/pages/MapPage.dart';
import 'package:rental/pages/SettingsPage.dart';

import '../main.dart';
import '../pages/ChatsPage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = (settings.arguments != null) ? (settings.arguments as Map<String, dynamic>) : null;

    switch (settings.name) {
      case AppRoutes.categoryEstateList:
        return MaterialPageRoute(
          builder: (_) => AllEstatesPage(
            title: args?['title'],
            estates: args?['estates'],
          ),
        );
      case AppRoutes.estateDetails:
        return MaterialPageRoute(
          builder: (_) => EstateDetailsPage(
            estate: args?['estate'],
          ),
        );
      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => SettingsPage());
      case AppRoutes.favorites:
        return MaterialPageRoute(
          builder: (_) => FavoritesPage(
            estates: args?['estates']
          )
        );
      case AppRoutes.chats:
        return MaterialPageRoute(
          builder: (_) => ChatsPage()
        );
      case AppRoutes.map:
        return MaterialPageRoute(
          builder: (_) => MapPage(
              cities: args?['cities']
          )
        );
      case AppRoutes.home:
      default:
        return MaterialPageRoute(builder: (_) => const MainPage());
    }
  }
}

class AppRoutes{
  static const String home = '/';
  static const String categoryEstateList = '/category-estate-list';
  static const String estateDetails = '/estate-details';
  static const String settings = '/settings';
  static const String favorites = '/favorites';
  static const String chats = '/chats';
  static const String map = '/map';
}