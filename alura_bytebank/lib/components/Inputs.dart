import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final TextEditingController _controlador;
  final String _rotulo;
  final String _dica;
  final IconData? _icone;

  const Input(
    this._controlador,
    this._rotulo,
    this._dica, {
    IconData? icone,
    Key? key,
  })  : _icone = icone,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _controlador,
        decoration: InputDecoration(
          icon: _icone != null ? Icon(_icone) : null,
          labelText: _rotulo,
          hintText: _dica,
        ),
        style: const TextStyle(fontSize: 16.0),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
