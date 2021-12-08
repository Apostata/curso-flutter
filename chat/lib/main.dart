import 'package:chat/pages/auth_or_chat_page.dart';
import 'package:chat/pages/auth_page.dart';
import 'package:chat/providers/main.provider.dart';
import 'package:chat/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Chat app',
        theme: theme,
        home: const AuthOrChat(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
