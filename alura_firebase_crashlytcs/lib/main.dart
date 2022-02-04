import 'dart:async';

import 'package:alura_firebase_crashlytcs/pages/dashboard_page.dart';
import 'package:alura_firebase_crashlytcs/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    } else {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      FirebaseCrashlytics.instance.setUserIdentifier('rene123');
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    }

    runApp(const ByteBankApp());
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
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
