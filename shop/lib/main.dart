import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Theme/theme.dart';
import 'package:shop/providers/cart.provider.dart';
import 'package:shop/providers/products.provider.dart';
import 'routes/routes.dart' show routes, onGenerateRoutes, onUnknownRoute;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Products()),
        ChangeNotifierProvider(create: (_) => Cart()),
      ],
      child: MaterialApp(
        title: 'Shop',
        theme: theme,
        // home: const ProductsPage(),
        debugShowCheckedModeBanner: false,
        routes: routes,
        onGenerateRoute: onGenerateRoutes,
        onUnknownRoute: onUnknownRoute,
      ),
    );
  }
}
