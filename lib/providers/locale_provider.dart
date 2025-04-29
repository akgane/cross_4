import 'package:flutter/cupertino.dart';

class LocaleProvider extends ChangeNotifier{
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale locale){
    if(!['en', 'ru', 'kk'].contains(locale.languageCode)) return;
    _locale = locale;
    notifyListeners();
  }

  void clearLocale(){
    _locale = const Locale('en');
    notifyListeners();
  }
}