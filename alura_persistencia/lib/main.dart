import 'package:alura_persistencia/pages/dashboard_page.dart';
import 'package:alura_persistencia/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ByteBankApp());
}

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: const DashboardPage(),
      home: const DashboardPage(),
      theme: theme,
      debugShowCheckedModeBanner: false,
    );
  }
}
