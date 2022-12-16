import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  var _themeData = ThemeData.light();
  var _isDark = true;

  ThemeData get theme => _themeData;
  changeTheme() {
    _isDark = !_isDark;
    _themeData = _isDark
        ? ThemeData.dark().copyWith(
            canvasColor: Colors.black54,
            textTheme: ThemeData.light().textTheme,
            backgroundColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
            cardColor: Colors.deepOrange[100],
            cardTheme: CardTheme(),
            unselectedWidgetColor: Colors.black54,
            appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(color: Colors.deepOrange[100]),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedLabelStyle: TextStyle(color: Colors.deepOrange[100]),
              selectedIconTheme: IconThemeData(
                color: Colors.deepOrange[100],
              ),
              unselectedLabelStyle: TextStyle(color: Colors.black54),
              unselectedIconTheme: IconThemeData(
                color: Colors.black54,
              ),
            ))
        : ThemeData.light();
    notifyListeners();
  }
}
