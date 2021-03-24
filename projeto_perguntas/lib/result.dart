import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final String _texto;
  final int _score;
  final void Function() _resetar;

  Result(this._texto, this._score, this._resetar);

  String get fraseResultado {
    if (_score < 8) {
      return 'Parabéns';
    } else if (_score < 12) {
      return 'Parabéns';
    } else if (_score < 16) {
      return 'Impressionante';
    } else {
      return 'Nível Jedi';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            fraseResultado + this._texto + this._score.toString(),
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          width: double.infinity,
          child: TextButton(
            onPressed: _resetar,
            child: Text(
              'Reiniciar?',
              style: TextStyle(color: Colors.deepPurple),
            ),
          ),
        )
      ],
    );
  }
}
