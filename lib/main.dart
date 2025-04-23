import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rental/data/data.dart';
import 'package:rental/models/Category.dart';
import 'package:rental/pages/ChatsPage.dart';
import 'package:rental/pages/FavoritesPage.dart';
import 'package:rental/pages/MapPage.dart';
import 'package:rental/pages/SettingsPage.dart';
import 'package:rental/utils/FavoriteUtils.dart';
import 'package:rental/utils/SortUtils.dart';
import 'package:rental/utils/ThemeProvider.dart';
import 'package:rental/widgets/main_widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'models/City.dart';
import 'models/Estate.dart';
import 'models/Users.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
    create: (_) => ThemeProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.orange,
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.grey[50],
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.black),
      bodySmall: TextStyle(color: Colors.grey[600]),
      titleMedium: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
    ),
    iconTheme: IconThemeData(color: Colors.black),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.orange,
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.orange,
      secondary: Colors.deepOrange,
      // onBackground: Colors.black,
      onSurface: Colors.black,
      error: Colors.red,
    ),
  );

  final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.deepOrange,
    scaffoldBackgroundColor: Color(0xff212529),
    cardColor: Colors.grey[850],
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.grey[400]),
      titleMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
    ),
    iconTheme: IconThemeData(color: Colors.white),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xff343a40),
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.dark(
      primary: Colors.deepOrange,
      secondary: Colors.orange,
      // onBackground: Colors.white,
      onSurface: Colors.transparent,
      error: Colors.red,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Rental Estate App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.themeMode,
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

  Future<List<City>> fetchCities() async{
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('cities').get();
    return snapshot.docs.map((doc) => City.fromFirestore(doc)).toList();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        fetchCategories(),
        fetchEstates(),
        fetchExampleUser(),
        fetchCities()
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
        final List<City> cities = snapshot.data![3] as List<City>;

        String est = "";
        for(Estate estate in estates){
          est += "${estate.title} | ${estate.views}\n";
        }
        print(est);
        print(estates.length);

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                IconButton(icon: Icon(Icons.camera_alt), onPressed: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? photo = await picker.pickImage(source: ImageSource.camera);
                }),
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
                        builder: (context) => ChatsPage()
                      )
                    );
                  },
                ),
                IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsPage()
                        )
                      );
                  }
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MapPage(cities: cities)));
            },
            backgroundColor: Theme.of(context).primaryColor,
            shape: CircleBorder(),
            child: Icon(Icons.map),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
