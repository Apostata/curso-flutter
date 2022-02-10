import 'package:alura_bloc_intl/models/I18nMessages.dart';

class DashboardI18nLazy {
  final I18nMessages _messages;
  DashboardI18nLazy(this._messages);
  String get transfer => _messages.get('transfer');

  String get transaction_feed => _messages.get('transaction_feed');

  String get change_name => _messages.get('change_name');
}
