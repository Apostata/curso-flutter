import 'package:flutter/material.dart';
import 'package:places/routes/routes.dart' show onGenerateRoutes;
import 'package:places/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:places/providers/main.providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'My Places',
        theme: theme,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerateRoutes,
      ),
    );
  }
}
