import 'package:alura_bytebank/components/ItemTransferencia.dart';
import 'package:alura_bytebank/models/Transferencia.dart';
import 'package:flutter/material.dart';

class ListaTransferencia extends StatelessWidget {
  final List<Transferencia> _transferencias;

  const ListaTransferencia(this._transferencias, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _transferencias.length,
      itemBuilder: (ctx, indice) {
        return ItemTransferencia(_transferencias[indice]);
      },
    );
  }
}
