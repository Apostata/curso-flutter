import 'package:alura_bytebank/pages/ListaTransferenca_page.dart';
import 'package:alura_bytebank/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ByteBank());
}

class ByteBank extends StatelessWidget {
  const ByteBank({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const ListaTransferenciaPage(),
        debugShowCheckedModeBanner: false,
        theme: theme);
  }
}
