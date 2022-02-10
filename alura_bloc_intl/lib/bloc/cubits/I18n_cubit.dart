import 'dart:async';

import 'package:alura_bloc_intl/models/I18nMessages.dart';
import 'package:alura_bloc_intl/components/I18nLoading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class I18nMessagesCubit extends Cubit<I18nMessagesState> {
  I18nMessagesCubit() : super(I18nInitState());
  reload() async {
    emit(I18nInitState());
    I18nMessages messages = I18nMessages({
      "transfer": "TRANSFER",
      "transaction_feed": "TRANSACTION FEED",
      "change_name": "CHANGE NAME",
    });
    Timer(
      Duration(seconds: 2),
      () => emit(
        I18nLoadedState(messages),
      ),
    );
  }
}
