import 'package:flutter/material.dart';
import 'package:pomodoro/store/pomodore.store.dart';
import 'package:provider/provider.dart';

class TimeInput extends StatelessWidget {
  final int valor;
  final String titulo;
  final void Function()? inc;
  final void Function()? dec;

  const TimeInput({
    Key? key,
    required this.valor,
    required this.titulo,
    this.inc,
    this.dec,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoreStore>(context);
    return Column(
      children: [
        Text(
          titulo,
          style: const TextStyle(
            fontSize: 25,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: dec,
              child: const Icon(
                Icons.arrow_downward,
                color: Colors.white,
              ),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
                primary: store.isWorking() ? Colors.red : Colors.green,
              ),
            ),
            Text(
              '$valor min',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            ElevatedButton(
              onPressed: inc,
              child: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
                primary: store.isWorking() ? Colors.red : Colors.green,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
