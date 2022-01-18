// import 'package:alura_bytebank/pages/FormularioTransferenciaPage.dart';
import 'package:alura_bytebank/pages/ListaTransferenca_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ByteBank());
}

class ByteBank extends StatelessWidget {
  const ByteBank({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ListaTransferenciaPage(),
      // home: FormularioTransferenciaPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
