import 'dart:async';

import 'package:alura_bloc_intl/components/I18nLoading.dart';
import 'package:alura_bloc_intl/models/I18nMessages.dart';
import 'package:alura_bloc_intl/services/18nMessages_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class I18nMessagesCubit extends Cubit<I18nMessagesState> {
  final i18nService = I18nMessagesService();
  I18nMessagesCubit() : super(I18nInitState());
  reload({
    required String viewKey,
    required String language,
  }) async {
    emit(I18nInitState());
    final resp = await i18nService.findMessages(
      viewKey: viewKey,
      language: language,
    );
    final messages = I18nMessages(resp);
    emit(
      I18nLoadedState(messages),
    );
  }
}
