import 'package:alura_bytebank/models/Transferencia.dart';
import 'package:alura_bytebank/pages/FormularioTransferenciaPage.dart';
import 'package:flutter/material.dart';
import '../components/ListaTransferencia.dart';

class ListaTransferenciaPage extends StatefulWidget {
  const ListaTransferenciaPage({Key? key}) : super(key: key);
  // final List<Transferencia> _transferencias = [];

  @override
  State<ListaTransferenciaPage> createState() => _ListaTransferenciaPageState();
}

class _ListaTransferenciaPageState extends State<ListaTransferenciaPage> {
  final List<Transferencia> _transferencias = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transferências'),
      ),
      body: ListaTransferencia(_transferencias),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => const FormularioTransferenciaPage(),
            ),
          ).then(
            (transferencia) => {
              if (transferencia != null)
                {
                  setState(() {
                    _transferencias.add(transferencia);
                  })
                }
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
