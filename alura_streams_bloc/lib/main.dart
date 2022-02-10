import 'package:alura_streams_bloc/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/containers.dart';

class LogObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint('${bloc.runtimeType} > $change');
    super.onChange(bloc, change);
  }
}

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () {
      runApp(
        const ByteBankApp(),
      );
    },
    blocObserver: LogObserver(),
  );
}

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const DashboardContiner(
        initialState: 'Rene',
      ),
      theme: theme,
      debugShowCheckedModeBanner: false,
    );
  }
}
