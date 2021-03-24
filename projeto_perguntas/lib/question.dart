import 'package:flutter/material.dart';

class Questao extends StatelessWidget {
  final String texto;
  Questao(this.texto); //construtor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(texto,
          style: TextStyle(
            fontSize: 28,
          ),
          textAlign: TextAlign.center),
    );
  }
}
