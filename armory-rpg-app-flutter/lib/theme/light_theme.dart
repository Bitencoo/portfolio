import 'package:flutter/material.dart';
import 'package:rpg_app/theme/colors.dart';

ThemeData themeDataLight = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 218, 95, 54),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color.fromARGB(255, 218, 95, 54),
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.black,
  ),
  backgroundColor: lightBackground,
  scaffoldBackgroundColor: lightBackground,
  textTheme: const TextTheme(
    caption: TextStyle(color: Colors.white),
    headline2: TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      color: Colors.black,
      fontSize: 20,
    ),
    headline4: TextStyle(
      color: Colors.black,
      fontSize: 16,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.white),
    ),
  ),
);
