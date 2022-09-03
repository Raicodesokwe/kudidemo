import 'package:flutter/material.dart';

enum AppTheme { Light, Dark, Blue, Green, Orange, Pink }

/// Returns enum value name without enum class name.
String enumName(AppTheme anyEnum) {
  return anyEnum.toString().split('.')[1];
}

final appThemeData = {
  AppTheme.Green: ThemeData.light().copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: const Color(0xFFd6d912),
      backgroundColor: const Color(0xFFd6d912),
      appBarTheme: appBarTheme,
      iconTheme: const IconThemeData(color: Colors.black),
      textTheme: TextTheme(
          bodyText2:
              TextStyle(color: Colors.black, fontFamily: 'grifterbold'))),
  AppTheme.Dark: ThemeData.dark().copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Colors.grey[900],
      backgroundColor: Colors.grey[900],
      appBarTheme: appBarTheme,
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: TextTheme(
          bodyText2:
              TextStyle(color: Colors.white, fontFamily: 'grifterbold'))),
  AppTheme.Blue: ThemeData.light().copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: const Color(0xFF1512d9),
      backgroundColor: const Color(0xFF1512d9),
      appBarTheme: appBarTheme,
      iconTheme: const IconThemeData(color: Colors.black),
      textTheme: TextTheme(
          bodyText2:
              TextStyle(color: Colors.black, fontFamily: 'grifterbold'))),
  AppTheme.Light: ThemeData.light().copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Colors.grey[300],
      backgroundColor: Colors.grey[300],
      appBarTheme: appBarTheme,
      iconTheme: const IconThemeData(color: Colors.black),
      textTheme: TextTheme(
          bodyText2:
              TextStyle(color: Colors.black, fontFamily: 'grifterbold'))),
  AppTheme.Pink: ThemeData.light().copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: const Color(0xFFd912b4),
      backgroundColor: const Color(0xFFd912b4),
      appBarTheme: appBarTheme,
      iconTheme: const IconThemeData(color: Colors.black),
      textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black, fontFamily: 'grifterbold')))
};
const appBarTheme = AppBarTheme(centerTitle: false, elevation: 0);
