import 'package:calculadora/Components/button.dart';
import 'package:flutter/material.dart';

class ButtonRow extends StatelessWidget {
  final List<Button> buttons;

  const ButtonRow(this.buttons, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons.fold(<Widget>[], (list, btn) {
          list.isEmpty
              ? list.add(btn)
              : list.addAll([const SizedBox(width: 1), btn]);
          return list;
        }),
      ),
    );
  }
}
