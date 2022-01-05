import 'package:flutter/material.dart';
import 'package:pomodoro/pages/Pomodoro.dart';
import 'package:pomodoro/store/pomodore.store.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PomodoreStore>(
          create: (_) => PomodoreStore(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Pomodoro(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
