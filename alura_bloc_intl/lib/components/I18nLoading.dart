import 'package:alura_bloc_intl/bloc/containers/I18n_container.dart';
import 'package:alura_bloc_intl/bloc/cubits/I18n_cubit.dart';
import 'package:alura_bloc_intl/components/CenteredMessagePage.dart';
import 'package:alura_bloc_intl/components/loadingPage.dart';
import 'package:alura_bloc_intl/models/I18nMessages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class I18nMessagesState {
  I18nMessagesState();
}

class I18nInitState extends I18nMessagesState {
  I18nInitState();
}

class I18nLoadingState extends I18nMessagesState {
  I18nLoadingState();
}

class I18nLoadedState extends I18nMessagesState {
  final I18nMessages _messages;
  I18nLoadedState(this._messages);
}

class I18nErrorState extends I18nMessagesState {
  I18nErrorState();
}

class I18nLoading extends StatelessWidget {
  final I18nWidgetCreactor creator;
  const I18nLoading({
    Key? key,
    required this.creator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<I18nMessagesCubit, I18nMessagesState>(
      builder: (context, state) {
        if (state is I18nInitState || state is I18nLoadingState) {
          return const LoadingPage();
        }
        if (state is I18nLoadedState) {
          final messages = state._messages;
          debugPrint(messages.toString());
          return creator(messages);
        }
        return const CenteredMessagePage(message: 'Unknow Error');
      },
    );
  }
}
