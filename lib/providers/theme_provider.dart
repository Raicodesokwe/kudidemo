import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme/theme_enum.dart';

class ThemeProvider extends ChangeNotifier {
  final _kThemePreference = "theme_preference";
  ThemeData? _themeData;
  ThemeData? get themeData {
    return _themeData ??= appThemeData[AppTheme.Light];
  }

  ThemeProvider() {
    // We load theme at the start
    _loadTheme();
  }

  void _loadTheme() {
    debugPrint("Entered loadTheme()");
    SharedPreferences.getInstance().then((prefs) {
      int preferredTheme = prefs.getInt(_kThemePreference) ?? 0;
      _themeData = appThemeData[AppTheme.values[preferredTheme]];
      // Once theme is loaded - notify listeners to update UI
      notifyListeners();
    });
  }

  setTheme(AppTheme theme) async {
    _themeData = appThemeData[theme];
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt(_kThemePreference, AppTheme.values.indexOf(theme));
    notifyListeners();
  }
}
