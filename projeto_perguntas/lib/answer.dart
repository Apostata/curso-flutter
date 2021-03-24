import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String _texto;
  final int _index;
  final void Function() _onPressed;

  Answer(this._texto, this._index, this._onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
        child: Text(
          '${this._index}. ${this._texto}',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: _onPressed,
      ),
    );
  }
}
