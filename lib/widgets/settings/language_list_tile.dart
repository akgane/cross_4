import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental/utils/user_preferences.dart';

import '../../providers/locale_provider.dart';
import '../../providers/theme_provider.dart';

class LanguageListTile extends StatelessWidget{
  final String title;
  final String locale;
  final LocaleProvider locProvider;
  final ThemeProvider themeProvider;
  final UserPreferences userPrefs;

  const LanguageListTile({
    super.key,
    required this.title,
    required this.locale,
    required this.locProvider,
    required this.themeProvider,
    required this.userPrefs
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
        onTap: (){
          locProvider.setLocale(Locale(locale));

          userPrefs.saveUserPreferences(themeProvider.getTheme(), locale);
          
          Navigator.of(context).pop();
        }
    );
  }
}
