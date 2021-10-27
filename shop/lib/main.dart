import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shop/Theme/theme.dart';
import 'package:shop/providers/mainProviders.dart';
import 'routes/routes.dart' show onGenerateRoutes, onUnknownRoute;
import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart'; // se for web remove # da url
Future main() async {await dotenv.load(fileName: ".env");
  configureApp();
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
        title: 'Shop',
        theme: theme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        // routes: routes,
        onGenerateRoute: onGenerateRoutes,
        onUnknownRoute: onUnknownRoute,
      ),
    );
  }
}
