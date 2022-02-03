import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: Colors.green[900],
    secondary: Colors.blue[700], // Your accent color
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> state) {
        if (state.contains(MaterialState.disabled)) {
          return Colors.grey;
        }
        return Colors.blue[700];
      }),
      foregroundColor: //text color
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> state) {
        if (state.contains(MaterialState.disabled)) {
          return Colors.grey[300]!;
        }
        return Colors.blue[700]!;
      }),
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue[700],
    disabledColor: Colors.grey,
  ),
);
