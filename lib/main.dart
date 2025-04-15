import 'package:flutter/material.dart';
import 'package:rental/data/data.dart';
import 'package:rental/models/Category.dart';
import 'package:rental/pages/ChatsPage.dart';
import 'package:rental/pages/FavoritesPage.dart';
import 'package:rental/utils/FavoriteUtils.dart';
import 'package:rental/widgets/main_widgets.dart';

import 'models/Estate.dart';
import 'models/Users.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rental Estate App',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});


  @override
  Widget build(BuildContext context) {
    final List<Category> categories = List.from(exampleCategories);
    final List<Estate> estates = List.from(exampleEstates);
    final currentUser = exampleUsers.first;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TopBar(username: currentUser.username),
            SizedBox(height: 16),
            CategoriesSection(categories: categories, allEstates: estates),
            SizedBox(height: 24),
            Section(title: "New", estates: estates),
            SizedBox(height: 24),
            Section(title: "Popular", estates: estates),
            SizedBox(height: 24),
            Section(title: "Test", estates: estates)
          ]
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: Icon(Icons.home), onPressed: () {}),
            IconButton(icon: Icon(Icons.favorite), onPressed: () async {
              List<Estate> favorites = await FavoriteUtils.getFavoriteEstates(estates);
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => FavoritesPage(estates: favorites)
                )
              );
            }),
            SizedBox(width: 40),
            IconButton(icon: Icon(Icons.message), onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatsPage()
                )
              );
            }),
            IconButton(icon: Icon(Icons.settings), onPressed: () {}),
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.orange,
        shape: CircleBorder(),
        child: Icon(Icons.swap_horiz),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
