import 'package:alura_bloc_intl/bloc/cubits/Locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalizationContainer extends StatelessWidget {
  final String language;
  final Widget child;
  const LocalizationContainer({
    Key? key,
    required this.child,
    required this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocaleCubit>(
      create: (context) => LocaleCubit(language),
      child: child,
    );
  }
}
