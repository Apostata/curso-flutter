import 'package:flutter/material.dart';

final theme = ThemeData(
  backgroundColor: Colors.grey[200],
  colorScheme: ColorScheme
  .fromSwatch(
    primarySwatch: Colors.purple,
  )
  .copyWith(
    secondary: Colors.deepOrange,
  ),
  fontFamily: 'Lato',
);
