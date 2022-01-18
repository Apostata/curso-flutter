class Transferencia {
  final double valor;
  final int numeroConta;
  Transferencia({required this.valor, required this.numeroConta});

  @override
  String toString() {
    super.toString();
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}
