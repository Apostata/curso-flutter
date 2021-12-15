import 'package:chat/pages/auth_or_chat_page.dart';
import 'package:chat/providers/main.provider.dart';
import 'package:chat/theme/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  if (kIsWeb) {
    String filename = '.env.web';
    await dotenv.load(fileName: filename);
  }

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
