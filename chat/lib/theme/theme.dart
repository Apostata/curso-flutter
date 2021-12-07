import 'package:flutter/material.dart';

final theme = ThemeData(
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
      .copyWith(secondary: Colors.blueGrey[200]),
  buttonBarTheme: const ButtonBarThemeData(
    buttonTextTheme: ButtonTextTheme.primary,
  ),
  textTheme: const TextTheme(
    bodyText2: TextStyle(color: Colors.white),
    headline6: TextStyle(color: Colors.white),
  ),
);
