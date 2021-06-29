import 'package:flutter/material.dart';

final theme = ThemeData(
  primarySwatch: Colors.pink,
  accentColor: Colors.amber,
  canvasColor: Color.fromRGBO(255, 254, 229, 1),
  fontFamily: 'Raleway',
  textTheme: ThemeData.light().textTheme.copyWith(
        headline6: TextStyle(
          fontSize: 20,
          fontFamily: 'RobotoCondensed',
        ),
      ),
);
