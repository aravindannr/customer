import 'package:flutter/material.dart';
import 'package:teresa_customer/utils/theme/theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = darkMode;
  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
