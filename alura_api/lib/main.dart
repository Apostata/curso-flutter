import 'package:alura_api/pages/dashboard_page.dart';
import 'package:alura_api/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();

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
