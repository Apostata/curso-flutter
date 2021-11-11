import 'package:flutter/material.dart';

final theme = ThemeData(
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
      .copyWith(secondary: Colors.amberAccent),
  buttonTheme: const ButtonThemeData(buttonColor: Colors.black),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.amber),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(color: Colors.black)
        )
    )
  ),
);
