import 'package:alura_bytebank/components/FormularioTransferencia.dart';
import 'package:flutter/material.dart';

class FormularioTransferenciaPage extends StatelessWidget {
  const FormularioTransferenciaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ciando transferencia'),
      ),
      body: FormularioTransferencia(),
    );
  }
}
