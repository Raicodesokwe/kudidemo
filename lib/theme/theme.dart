import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';


class ThemeProvider extends ChangeNotifier {
 final String key = "theme";
 late SharedPreferences _prefs;
 late bool _darkTheme;

  bool get  darkTheme => _darkTheme;
  
  ThemeProvider() {
    _darkTheme = true;
    _loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    // if(_prefs == null)
      _prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = _prefs.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs()async {
    await _initPrefs();
    _prefs.setBool(key, _darkTheme);
  }
}

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Colors.grey[300],
      appBarTheme: appBarTheme,
      iconTheme:const IconThemeData(color: Colors.black),
    
      textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.black));
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor:Colors.grey[900],
      appBarTheme: appBarTheme,
      iconTheme:const IconThemeData(color: Colors.white),
    
      textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white));
}

const appBarTheme = AppBarTheme(centerTitle: false, elevation: 0);
