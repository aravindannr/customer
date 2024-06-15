import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: Colors.white,
    primary: Colors.black,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.white,
    filled: true,
    prefixIconColor: Colors.black,
    suffixIconColor: Colors.black,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Colors.red,
        width: 1,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Colors.black,
        width: 1,
      ),
    ),
  ),
);

ThemeData darkMode = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 16,
    ),
  ),
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    surface: Colors.black,
    primary: Colors.white,
    secondary: Colors.white70,
    // onPrimary: Colors.black,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.white,
    filled: true,
    prefixIconColor: Colors.black,
    suffixIconColor: Colors.black,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Colors.red,
        width: 1,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 1,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Colors.black,
        width: 1,
      ),
    ),
  ),
);
