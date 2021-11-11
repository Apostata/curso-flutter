import 'package:flutter/material.dart';
import 'package:places/routes/routes.dart' show onGenerateRoutes;
import 'package:places/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Places',
      theme: theme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoutes,

    );
  }
}
