import 'package:chat/models/auth_service.model.dart';
import 'package:chat/pages/auth_page.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/loading_page.dart';
import 'package:chat/services/chat_notification.service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

final ENV = dotenv.env;

class AuthOrChat extends StatelessWidget {
  const AuthOrChat({Key? key}) : super(key: key);

  Future<void> init(BuildContext context) async {
    // await Firebase.initializeApp();
    if (kIsWeb) {
      final options = FirebaseOptions(
        apiKey: ENV['apiKey']!,
        authDomain: ENV['authDomain'],
        projectId: ENV['projectId']!,
        storageBucket: ENV['storageBucket'],
        messagingSenderId: ENV['messagingSenderId']!,
        appId: ENV['appId']!,
      );

      await Firebase.initializeApp(options: options);
    } else {
      await Firebase.initializeApp();
    }
    await Provider.of<ChatNotificationService>(
      context,
      listen: false,
    ).init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(context),
      builder: (fbctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingPage();
        }
        return StreamBuilder(
          stream: AuthService().userChanges,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingPage();
            } else {
              return snapshot.hasData ? const ChatPage() : const AuthPage();
            }
          },
        );
      },
    );
  }
}
