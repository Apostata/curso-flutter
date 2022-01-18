import 'package:alura_bytebank/components/ItemTransferencia.dart';
import 'package:alura_bytebank/models/Transferencia.dart';
import 'package:flutter/material.dart';

class ListaTransferencia extends StatelessWidget {
  const ListaTransferencia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemTransferencia(
          Transferencia(valor: 100.23, numeroConta: 1000),
        ),
        ItemTransferencia(
          Transferencia(valor: 202.54, numeroConta: 1001),
        ),
        ItemTransferencia(
          Transferencia(valor: 376.98, numeroConta: 1002),
        )
      ],
    );
  }
}
