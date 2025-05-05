import 'package:flutter/material.dart';
import 'package:rental/pages/all_estates_page.dart';
import 'package:rental/pages/chat_details_page.dart';
import 'package:rental/pages/estate_details_page.dart';
import 'package:rental/pages/favorites_page.dart';
import 'package:rental/pages/map_page.dart';
import 'package:rental/pages/settings_page.dart';
import 'package:rental/widgets/auth/auth_wrapper.dart';

import '../main.dart';
import '../pages/chats_page.dart';
import 'app_routes.dart';

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
      case AppRoutes.chatDetails:
        return MaterialPageRoute(
          builder: (_) => ChatDetailsPage(
            chat: args?['chat'],
          )
        );
      case AppRoutes.auth:
        return MaterialPageRoute(
          builder: (_) => AuthWrapper()
        );
      case AppRoutes.home:
      default:
        return MaterialPageRoute(builder: (_) => const MainPage());
    }
  }
}