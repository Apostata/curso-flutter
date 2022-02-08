import 'package:intl/intl.dart';

String toCurrency(double value) {
  final NumberFormat realFormat = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
    decimalDigits: 2,
  );
  return realFormat.format(value);
}
