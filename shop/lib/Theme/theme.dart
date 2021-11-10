import 'package:flutter/material.dart';
import 'package:shop/helpers/Custom_route_transition.dart';

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
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.macOS: CustomPageTransitionBuilder(),
    }
  )
);
