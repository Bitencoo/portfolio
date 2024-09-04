import 'package:flutter/material.dart';
import 'package:rpg_app/theme/colors.dart';

ThemeData themeDataDark = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 218, 95, 54),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color.fromARGB(255, 218, 95, 54),
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.black,
  ),
  backgroundColor: darkBackground,
  scaffoldBackgroundColor: darkBackground,
  textTheme: const TextTheme(
    caption: TextStyle(color: Colors.white),
    headline2: TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
    headline4: TextStyle(
      color: Colors.white,
      fontSize: 16,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.black),
    ),
  ),
);
