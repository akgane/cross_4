import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental/models/Category.dart';
import 'package:rental/providers/locale_provider.dart';

import 'package:rental/utils/sort_utils.dart';
import 'package:rental/providers/theme_provider.dart';
import 'package:rental/utils/data_service.dart';
import 'package:rental/misc/route_generator.dart';
import 'package:rental/utils/theme_data.dart';
import 'package:rental/widgets/main/bottom_app_bar.dart';
import 'package:rental/widgets/main/categories_section.dart';
import 'package:rental/widgets/main/section.dart';
import 'package:rental/widgets/main/top_bar.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'misc/app_routes.dart';
import 'models/City.dart';
import 'models/Estate.dart';
import 'models/Users.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => LocaleProvider())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      title: 'Rental Estate App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.themeMode,
      locale: localeProvider.locale,
      home: MainPage(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      onGenerateRoute: RouteGenerator.generateRoute,
      localizationsDelegates: const
      [
        AppLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        Locale('en'),
        Locale('ru'),
        Locale('kk')
      ],
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dataService = DataService();
    final theme = Theme.of(context);

    return FutureBuilder(
      future: Future.wait([
        dataService.fetchCategories(),
        dataService.fetchEstates(),
        dataService.fetchExampleUser(),
        dataService.fetchCities()
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

        final loc = AppLocalizations.of(context);

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                TopBar(username: currentUser.username),
                SizedBox(height: 16),
                CategoriesSection(categories: categories, allEstates: estates),
                SizedBox(height: 24),
                Section(title: loc!.m_section_new, estates: SortUtils.getRandom(
                    15,
                    estates.map((estate) => estate.copyWith()).toList()
                )),
                SizedBox(height: 24),
                Section(title: loc.m_section_popular, estates: SortUtils.getRandom(
                  15,
                  estates.map((estate) => estate.copyWith()).toList()
                )),
                SizedBox(height: 24),
                Section(title: loc.m_section_hot, estates: SortUtils.getRandom(
                    10,
                    estates.map((estate) => estate.copyWith()).toList())
                )
              ],
            ),
          ),
          bottomNavigationBar: MyBottomAppBar(estates: estates),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.map, arguments: {'cities': cities}),
            backgroundColor: theme.primaryColor,
            shape: CircleBorder(),
            child: Icon(Icons.map),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
