import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental/providers/locale_provider.dart';
import 'package:rental/utils/user_preferences.dart';
import 'package:rental/widgets/settings/language_list_tile.dart';
import '../providers/theme_provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final locProvider = Provider.of<LocaleProvider>(context, listen: false);
    final userPrefs = UserPreferences();

    final theme = Theme.of(context);

    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc!.s_settings),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: Text(
                loc.s_dark_mode,
                style: theme.textTheme.bodyMedium,
              ),
              trailing: Switch(
                value: themeProvider.themeMode == ThemeMode.dark,
                onChanged: (value) {
                  themeProvider.toggleTheme();

                  userPrefs.saveUserPreferences(themeProvider.getTheme(), locProvider.getLocale());
                },
              ),
            ),
            Divider(),
            ListTile(
              title: Text(
                loc.s_notifications,
                style: theme.textTheme.bodyMedium,
              ),
              trailing: Switch(
                value: false,
                onChanged: (value) {
                  // TODO: реализовать
                },
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.language, color: theme.iconTheme.color),
                  SizedBox(width: 8),
                  Text(loc.s_language, style: theme.textTheme.bodyMedium),
                ],
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: theme.iconTheme.color),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Row(
                      children: [
                        Icon(Icons.language, color: theme.iconTheme.color),
                        SizedBox(width: 8),
                        Text(loc.s_language, style: theme.textTheme.bodyMedium),
                      ],
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LanguageListTile(title: 'English', locale: 'en', locProvider: locProvider, themeProvider: themeProvider, userPrefs: userPrefs),
                        LanguageListTile(title: 'Русский', locale: 'ru', locProvider: locProvider, themeProvider: themeProvider, userPrefs: userPrefs),
                        LanguageListTile(title: 'Қазақша', locale: 'kk', locProvider: locProvider, themeProvider: themeProvider, userPrefs: userPrefs),
                      ]
                    )
                  )
                );
              },
            ),
            ListTile(
              title: Text(
                loc.s_account_settings,
                style: theme.textTheme.bodyMedium,
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: theme.iconTheme.color),
              onTap: () {
                // TODO: реализовать переход
              },
            ),
            ListTile(
              title: Text(
                loc.s_privacy,
                style: theme.textTheme.bodyMedium,
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: theme.iconTheme.color),
              onTap: () {
                // TODO: реализовать переход
              },
            ),
            ListTile(
              title: Text(
                loc.s_about,
                style: theme.textTheme.bodyMedium,
              ),
              trailing: Icon(Icons.info_outline, color: theme.iconTheme.color),
              onTap: () {
                // TODO: показать информацию
              },
            ),
          ],
        ),
      ),
    );
  }
}
