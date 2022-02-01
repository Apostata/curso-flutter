import 'dart:convert';
import 'package:http/http.dart';
import '../http/webclient.dart';
import '../models/transaction_model.dart';

const baseUrl = 'http://192.168.0.101:8080/transactions';

class TransactionService {
  Future<List<Transaction>> findAll() async {
    // final url = Uri.parse('http://192.168.0.101:8080/transactions');
    final url = Uri.parse(baseUrl);
    final Response data = await httpClient.get(url).timeout(
          const Duration(seconds: 5),
        );
    final List<Transaction> transactions =
        (jsonDecode(data.body) as List<dynamic>).map(
      (trans) {
        return Transaction.fromJson(trans);
      },
    ).toList();
    return transactions;
  }

  Future<Transaction> save(Transaction transaction) async {
    final url = Uri.parse(baseUrl);

    final body = jsonEncode(transaction.toJson());

    final Response data = await httpClient.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'password': '1000',
      },
      body: body,
    );

    final dynamic response = jsonDecode(data.body);
    return Transaction.fromJson(response);
  }
}
