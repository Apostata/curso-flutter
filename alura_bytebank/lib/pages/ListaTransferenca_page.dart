import 'package:alura_bytebank/pages/FormularioTransferenciaPage.dart';
import 'package:flutter/material.dart';
import '../components/ListaTransferencia.dart';

class ListaTransferenciaPage extends StatelessWidget {
  const ListaTransferenciaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transferências'),
      ),
      body: const ListaTransferencia(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future<dynamic> routeReturn = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => const FormularioTransferenciaPage(),
            ),
          );
          routeReturn.then(
            (transferencia) => debugPrint(transferencia.toString()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
