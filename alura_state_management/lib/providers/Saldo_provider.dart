import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../helpers/currency.dart';

class Saldo with ChangeNotifier {
  double value;

  Saldo(this.value);

  void addValue(double value) {
    this.value += value;
    notifyListeners();
  }

  void removeValue(double value) {
    this.value -= value;
    notifyListeners();
  }

  @override
  String toString() {
    return toCurrency(value);
  }
}
