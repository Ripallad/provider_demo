import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  Locale current = Locale('en');

  changeLanguage() {
    (current.languageCode == 'en')
        ? current = Locale('hi')
        : current = Locale('en');
    notifyListeners();
  }
}
