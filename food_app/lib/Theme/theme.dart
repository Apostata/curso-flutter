import 'package:flutter/material.dart';

final theme = ThemeData(
  canvasColor: Color.fromRGBO(255, 254, 229, 1),
  fontFamily: 'Raleway',
  textTheme: ThemeData.light().textTheme
  .copyWith(
      headline6: TextStyle(
        fontSize: 20,
        fontFamily: 'RobotoCondensed',
      ),
    ), 
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.pink,
    )
  .copyWith(
    secondary: Colors.amber
  ),
);
