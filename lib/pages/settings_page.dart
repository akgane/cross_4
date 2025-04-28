import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: Text(
                "Dark Mode",
                style: theme.textTheme.bodyMedium,
              ),
              trailing: Switch(
                value: themeProvider.themeMode == ThemeMode.dark,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                },
              ),
            ),
            Divider(),
            ListTile(
              title: Text(
                "Notifications",
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
              title: Text(
                "Language",
                style: theme.textTheme.bodyMedium,
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: theme.iconTheme.color),
              onTap: () {
                // TODO: реализовать переход
              },
            ),
            ListTile(
              title: Text(
                "Account Settings",
                style: theme.textTheme.bodyMedium,
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: theme.iconTheme.color),
              onTap: () {
                // TODO: реализовать переход
              },
            ),
            ListTile(
              title: Text(
                "Privacy Policy",
                style: theme.textTheme.bodyMedium,
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: theme.iconTheme.color),
              onTap: () {
                // TODO: реализовать переход
              },
            ),
            ListTile(
              title: Text(
                "About",
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
