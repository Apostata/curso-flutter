import 'dart:convert';

import 'package:alura_bloc_intl/http/webclient.dart';
import 'package:http/http.dart';

Map<String, String> messagesMap = {
  "pt-br_dashboard":
      '7c53d7f31138884c9ee99380c6966d51/raw/c7303602927097cbc0213995dfad4da777fa607c/pt-br_dashboard_i18n.json',
  "en_dashboard":
      '8692501f4b6436dd1c5c1f706453e88a/raw/b564442ccce6ceaea2c415614a65878181164841/en_dashboard_i18n.json',
};

const String baseUrl = 'https://gist.githubusercontent.com/Apostata';

class I18nMessagesService {
  Future<Map<String, String>> findMessages({
    required String viewKey,
    required String language,
  }) async {
    final String messageMapKey = '${language}_$viewKey';
    final url = Uri.parse('$baseUrl/${messagesMap[messageMapKey]}');
    final Response data = await httpClient.get(url);
    final response = jsonDecode(data.body);
    final messages = Map<String, String>.from(response);
    return messages;
  }
}
