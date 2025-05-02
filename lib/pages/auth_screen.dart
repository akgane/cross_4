import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental/services/auth_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text(e.toString()),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('ОК'))],
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);

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
                          Text(
                            _isLogin ? loc!.a_login : loc!.a_register,
                            style: theme.textTheme.titleLarge
                          ),
                          TextFormField(
                            key: ValueKey('email'),
                            style: theme.textTheme.bodyMedium,
                            decoration: InputDecoration(
                              labelText: loc.a_email,
                              labelStyle: theme.textTheme.bodyMedium,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) =>
                            value!.contains('@') ? null : loc.a_enter_correct_email,
                            onSaved: (value) => _email = value!.trim(),
                          ),
                          TextFormField(
                            key: ValueKey('password'),
                            decoration: InputDecoration(
                              labelText: loc.a_password,
                              labelStyle: theme.textTheme.bodyMedium,
                            ),
                            obscureText: true,
                            validator: (value) =>
                            value!.length >= 6 ? null : loc.a_password_6_symbols,
                            onSaved: (value) => _password = value!,
                          ),
                          SizedBox(height: 16),
                          if (_isLoading)
                            CircularProgressIndicator(color: theme.colorScheme.primary),
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
                              child: Text(_isLogin ? loc.a_login : loc.a_register),
                            ),
                          TextButton(
                            style: TextButton.styleFrom(
                              textStyle: theme.textTheme.bodyLarge
                            ),
                            onPressed: () {
                              setState(() => _isLogin = !_isLogin);
                            },
                            child: Text(_isLogin
                                ? loc.a_not_registered
                                : loc.a_has_account),
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