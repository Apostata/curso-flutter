import 'package:alura_bytebank/components/Inputs.dart';
import 'package:alura_bytebank/models/Transferencia.dart';
import 'package:flutter/material.dart';

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controlardorNumeroConta =
      TextEditingController();
  final TextEditingController _controladorValor = TextEditingController();

  FormularioTransferencia({Key? key}) : super(key: key);

  void _criaTransferencia(BuildContext context) {
    final numeroConta = int.tryParse(_controlardorNumeroConta.text);
    final valor = double.tryParse(_controladorValor.text);
    if (numeroConta != null && valor != null) {
      final transferencia =
          Transferencia(numeroConta: numeroConta, valor: valor);
      Navigator.pop(context, transferencia);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Input(_controlardorNumeroConta, 'Número da conta', '0000'),
        Input(_controladorValor, 'Valor', '0.0', icone: Icons.monetization_on),
        ElevatedButton(
          onPressed: () => _criaTransferencia(context),
          child: const Text('Confirmar'),
        )
      ],
    );
  }
}
