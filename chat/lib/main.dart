import 'package:chat/pages/auth_page.dart';
import 'package:chat/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat app',
      theme: theme,
      home: const AuthPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
