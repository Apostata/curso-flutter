import 'package:alura_bloc_intl/bloc/containers/Dashboard_container.dart';
import 'package:alura_bloc_intl/bloc/containers/Localization_container.dart';
import 'package:alura_bloc_intl/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      home: const LocalizationContainer(
        child: DashboardContiner(
          initialState: 'Rene',
        ),
      ),
      theme: theme,
      debugShowCheckedModeBanner: false,
    );
  }
}
