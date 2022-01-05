import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro/components/TimerButton.dart';
import 'package:pomodoro/store/pomodore.store.dart';
import 'package:provider/provider.dart';

class TimerComponent extends StatelessWidget {
  const TimerComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoreStore>(context);

    return Observer(
      builder: (_) => Container(
        color: store.isWorking() ? Colors.red : Colors.green,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              store.isWorking() ? 'Hora de Trabalhar' : 'Hora de descansar',
              style: const TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '${store.minutes.toString().padLeft(2, '0')}:${store.seconds.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 120, color: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!store.initialized)
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                    ),
                    child: TimerButton(
                      texto: 'Iniciar',
                      icone: Icons.play_arrow,
                      click: store.startTimer,
                    ),
                  ),
                if (store.initialized)
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                    ),
                    child: TimerButton(
                      texto: 'Parar',
                      icone: Icons.stop,
                      click: store.stopTimer,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TimerButton(
                    texto: 'Reiniciar',
                    icone: Icons.refresh,
                    click: store.refreshTimer,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
