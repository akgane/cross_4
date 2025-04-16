import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rental/data/data.dart';
import 'package:rental/models/Category.dart';
import 'package:rental/pages/ChatsPage.dart';
import 'package:rental/pages/FavoritesPage.dart';
import 'package:rental/utils/FavoriteUtils.dart';
import 'package:rental/utils/SortUtils.dart';
import 'package:rental/widgets/main_widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'models/Estate.dart';
import 'models/Users.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

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

  Future<List<Estate>> fetchEstates() async{
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('estates').get();
    return snapshot.docs.map((doc) => Estate.fromFirestore(doc)).toList();
  }

  Future<List<Category>> fetchCategories() async{
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('categories').get();
    return snapshot.docs.map((doc) => Category.fromFirestore(doc)).toList();
  }

  Future<User> fetchExampleUser() async{
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').get();
    return User.fromFirestore(snapshot.docs[0]);
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        fetchCategories(),
        fetchEstates(),
        fetchExampleUser(),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text("No data available"));
        }

        final List<Category> categories = snapshot.data![0] as List<Category>;
        final List<Estate> estates = snapshot.data![1] as List<Estate>;
        final User currentUser = snapshot.data![2] as User;

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
                Section(title: "New", estates: SortUtils.getRandom(
                    15,
                    estates.map((estate) => estate.copyWith()).toList()
                )),
                SizedBox(height: 24),
                Section(title: "Popular", estates: SortUtils.getRandom(
                  15,
                  estates.map((estate) => estate.copyWith()).toList()
                )),
                SizedBox(height: 24),
                Section(title: "Hot", estates: SortUtils.getRandom(
                    10,
                    estates.map((estate) => estate.copyWith()).toList())
                )
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 8,
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(icon: Icon(Icons.camera_alt), onPressed: () {}),
                IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () async {
                    List<Estate> favorites = await FavoriteUtils.getFavoriteEstates(estates);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavoritesPage(estates: favorites),
                      ),
                    );
                  },
                ),
                SizedBox(width: 40),
                IconButton(
                  icon: Icon(Icons.message),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatsPage(),
                      ),
                    );
                  },
                ),
                IconButton(icon: Icon(Icons.settings), onPressed: () {}),
              ],
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
      },
    );
  }}
