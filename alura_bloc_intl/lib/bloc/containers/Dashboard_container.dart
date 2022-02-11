import 'package:alura_bloc_intl/bloc/containers/I18n_container.dart';
import 'package:alura_bloc_intl/bloc/cubits/Locale_cubit.dart';
import 'package:alura_bloc_intl/bloc/cubits/Name_cubit.dart';
import 'package:alura_bloc_intl/models/I18nMessages.dart';
import 'package:alura_bloc_intl/models/Locale_model.dart';
import 'package:alura_bloc_intl/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardContiner extends StatelessWidget {
  final String initialState;
  const DashboardContiner({
    Key? key,
    required this.initialState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (contextBloc) => NameCubit(initialState),
      child: I18nContainer(
        viewKey: "dashboard",
        language: BlocProvider.of<LocaleCubit>(context).state,
        // creator: (I18nMessages messages) => DashboardPage(messages: messages),
        creator: (I18nMessages messages) =>
            DashboardPage(i18n: DashboardI18nLazy(messages)),
      ),
    );
  }
}
