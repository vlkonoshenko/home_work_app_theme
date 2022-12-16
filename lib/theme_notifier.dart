import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  var _themeData = ThemeData.light();
  var _isDark = false;

  ThemeData get theme => _themeData;
  changeTheme() {
    _isDark = !_isDark;
    _themeData = _isDark ? ThemeData.dark() : ThemeData.light();
    notifyListeners();
  }
}
