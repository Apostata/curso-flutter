import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: Colors.green[900],
    secondary: Colors.blue[700], // Your accent color
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color?>(
        Colors.blue[700],
      ),
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue[700],
  ),
);
