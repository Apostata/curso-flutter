import 'package:alura_bloc_intl/bloc/cubits/I18n_cubit.dart';
import 'package:alura_bloc_intl/models/I18nMessages.dart';
import 'package:alura_bloc_intl/components/I18nLoading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// para gerar dinamico??
typedef I18nWidgetCreactor = Widget Function(I18nMessages messages);

class I18nContainer extends StatelessWidget {
  final I18nWidgetCreactor creator;
  const I18nContainer({Key? key, required this.creator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<I18nMessagesCubit>(
      create: (context) {
        final cubit = I18nMessagesCubit();
        cubit.reload();
        return cubit;
      },
      child: I18nLoading(creator: creator),
    );
  }
}
