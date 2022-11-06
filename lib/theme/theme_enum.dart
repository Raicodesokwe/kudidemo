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
      canvasColor: const Color(0xFFf6fa15),
      cardColor: const Color(0xFFb6b80f),
      appBarTheme: appBarTheme,
      iconTheme: const IconThemeData(color: Colors.black),
      textTheme: TextTheme(
          bodyText2: TextStyle(
        fontFamily: 'grifterbold',
        color: Colors.black,
      ))),
  AppTheme.Dark: ThemeData.dark().copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Colors.grey[900],
      backgroundColor: Colors.grey[900],
      canvasColor: Colors.grey.shade800,
      cardColor: Colors.black,
      appBarTheme: appBarTheme,
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: TextTheme(
          bodyText2: TextStyle(
        fontFamily: 'grifterbold',
        color: Colors.white,
      ))),
  AppTheme.Blue: ThemeData.dark().copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: const Color(0xFF12d6d9),
      backgroundColor: const Color(0xFF12d6d9),
      canvasColor: const Color(0xFF15f6fa),
      cardColor: const Color(0xFF0fb6b8),
      appBarTheme: appBarTheme,
      iconTheme: const IconThemeData(color: Colors.black),
      textTheme: TextTheme(
          bodyText2: TextStyle(
        fontFamily: 'grifterbold',
        color: Colors.black,
      ))),
  AppTheme.Light: ThemeData.light().copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Colors.grey[300],
      backgroundColor: Colors.grey[300],
      canvasColor: Colors.white,
      cardColor: Colors.grey.shade500,
      appBarTheme: appBarTheme,
      iconTheme: const IconThemeData(color: Colors.black),
      textTheme: TextTheme(
          bodyText2: TextStyle(
        fontFamily: 'grifterbold',
        color: Colors.black,
      ))),
  AppTheme.Pink: ThemeData.light().copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: const Color(0xFFd912b4),
      backgroundColor: const Color(0xFFd912b4),
      canvasColor: const Color(0xFFfa15cf),
      cardColor: const Color(0xFFb80f99),
      appBarTheme: appBarTheme,
      iconTheme: const IconThemeData(color: Colors.black),
      textTheme: TextTheme(
          bodyText2: TextStyle(
        fontFamily: 'grifterbold',
        color: Colors.black,
      ))),
  AppTheme.Orange: ThemeData.light().copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: const Color(0xFFd5642c),
      canvasColor: const Color(0xFFf57333),
      //chini
      cardColor: const Color(0xFFb55525),
      //juu
      backgroundColor: const Color(0xFFd5642c),
      appBarTheme: appBarTheme,
      iconTheme: const IconThemeData(color: Colors.black),
      textTheme: TextTheme(
          bodyText2: TextStyle(
        fontFamily: 'grifterbold',
        color: Colors.black,
      )))
};
const appBarTheme = AppBarTheme(centerTitle: false, elevation: 0);
