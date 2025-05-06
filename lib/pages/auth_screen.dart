import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental/misc/app_routes.dart';
import 'package:rental/providers/theme_provider.dart';
import 'package:rental/services/auth_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rental/utils/user_preferences.dart';

import '../providers/locale_provider.dart';
import '../widgets/settings/language_list_tile.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _isLogin = true;
  bool _isLoading = false;

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    final authService = Provider.of<AuthService>(context, listen: false);

    setState(() => _isLoading = true);

    try {
      if (_isLogin) {
        await authService.signInWithEmail(email: _email, password: _password);
      } else {
        await authService.signUpWithEmail(email: _email, password: _password);
      }
    } catch (e) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text('Error'),
              content: Text(e.toString()),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('ОК'),
                ),
              ],
            ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _enterGuest() async{
    setState(() => _isLoading = true);
    try{
      final authService = Provider.of<AuthService>(context, listen: false);

      await authService.enterGuestMode();
    }catch(e){
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
          title: Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('ОК'),
            ),
          ],
        ),
      );
    }finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);

    final locProvider = Provider.of<LocaleProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final userPrefs = UserPreferences();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: theme.scaffoldBackgroundColor,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _isLogin ? loc!.a_login : loc!.a_register,
                                style: theme.textTheme.titleLarge,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.language,
                                      color: theme.iconTheme.color,
                                    ),
                                    tooltip: loc.s_language,
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder:
                                            (context) => AlertDialog(
                                              title: Row(
                                                children: [
                                                  Icon(
                                                    Icons.language,
                                                    color:
                                                        theme.iconTheme.color,
                                                  ),
                                                  SizedBox(width: 8),
                                                  Text(
                                                    loc.s_language,
                                                    style:
                                                        theme
                                                            .textTheme
                                                            .bodyMedium,
                                                  ),
                                                ],
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  LanguageListTile(
                                                    title: 'English',
                                                    locale: 'en',
                                                    locProvider: locProvider,
                                                    themeProvider:
                                                        themeProvider,
                                                    userPrefs: userPrefs,
                                                  ),
                                                  LanguageListTile(
                                                    title: 'Русский',
                                                    locale: 'ru',
                                                    locProvider: locProvider,
                                                    themeProvider:
                                                        themeProvider,
                                                    userPrefs: userPrefs,
                                                  ),
                                                  LanguageListTile(
                                                    title: 'Қазақша',
                                                    locale: 'kk',
                                                    locProvider: locProvider,
                                                    themeProvider:
                                                        themeProvider,
                                                    userPrefs: userPrefs,
                                                  ),
                                                ],
                                              ),
                                            ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.dark_mode_outlined,
                                      color: theme.iconTheme.color,
                                    ),
                                    onPressed: () {
                                      themeProvider.toggleTheme();
                                      userPrefs.saveUserPreferences(
                                        themeProvider.getTheme(),
                                        locProvider.getLocale(),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          TextFormField(
                            key: ValueKey('email'),
                            style: theme.textTheme.bodyMedium,
                            decoration: InputDecoration(
                              labelText: loc.a_email,
                              labelStyle: theme.textTheme.bodyMedium,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator:
                                (value) =>
                                    value!.contains('@')
                                        ? null
                                        : loc.a_enter_correct_email,
                            onSaved: (value) => _email = value!.trim(),
                          ),
                          TextFormField(
                            key: ValueKey('password'),
                            style: theme.textTheme.bodyMedium,
                            decoration: InputDecoration(
                              labelText: loc.a_password,
                              labelStyle: theme.textTheme.bodyMedium,
                            ),
                            obscureText: true,
                            validator:
                                (value) =>
                                    value!.length >= 6
                                        ? null
                                        : loc.a_password_6_symbols,
                            onSaved: (value) => _password = value!,
                          ),
                          SizedBox(height: 16),
                          if (_isLoading)
                            CircularProgressIndicator(
                              color: theme.colorScheme.primary,
                            ),
                          if (!_isLoading)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                foregroundColor: theme.colorScheme.onPrimary,
                                minimumSize: Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: _submit,
                              child: Text(
                                _isLogin ? loc.a_login : loc.a_register,
                              ),
                            ),
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: theme.textTheme.bodyLarge,
                            ),
                            onPressed: () {
                              setState(() => _isLogin = !_isLogin);
                            },
                            child: Text(
                              _isLogin
                                  ? loc.a_not_registered
                                  : loc.a_has_account,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: theme.colorScheme.onPrimary,
                              minimumSize: Size(50, 35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: _enterGuest,
                            child: Text(loc.a_guest_mode),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
