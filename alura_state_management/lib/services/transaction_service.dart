import 'dart:convert';
// import 'package:alura_state_management/errors/httpException.dart';
import 'package:alura_state_management/errors/httpException.dart';
import 'package:http/http.dart';
import '../http/webclient.dart';
import '../models/transaction_model.dart';

const baseUrl = 'http://apostata.ddns.net/transactions';
// const baseUrl = 'http://192.168.0.102:8080/transactions';

const Map<int, String> _statusCodeResponses = {
  400: 'Error submitting transaction!',
  401: 'Authentication failed!',
  409: 'Transaction already exists!'
};

class TransactionService {
  Future<List<Transaction>> findAll() async {
    // final url = Uri.parse('http://192.168.0.101:8080/transactions');
    final url = Uri.parse(baseUrl);
    final Response data = await httpClient.get(url);
    final List<Transaction> transactions =
        (jsonDecode(data.body) as List<dynamic>).map(
      (trans) {
        return Transaction.fromJson(trans);
      },
    ).toList();
    return transactions;
  }

  Future<Transaction?> save(Transaction transaction, String? password) async {
    final url = Uri.parse(baseUrl);
    final body = jsonEncode(transaction.toJson());
    // await Future.delayed(const Duration(seconds: 10));
    final Response data = await httpClient.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'password': password!,
      },
      body: body,
    );

    if (data.statusCode == 200) {
      final dynamic response = jsonDecode(data.body);
      return Transaction.fromJson(response);
    }
    throw HttpException(
      message: _statusCodeResponses[data.statusCode] ?? 'Unknow Error',
      statusCode: data.statusCode,
    );
  }
}
