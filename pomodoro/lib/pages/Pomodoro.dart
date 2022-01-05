import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro/components/TimeInput.dart';
import 'package:pomodoro/components/TimerComponent.dart';
import 'package:pomodoro/store/pomodore.store.dart';
import 'package:provider/provider.dart';

class Pomodoro extends StatelessWidget {
  const Pomodoro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoreStore>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            child: TimerComponent(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Observer(
              builder: (_) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TimeInput(
                    valor: store.tempoTrabalho,
                    titulo: 'Trabalho',
                    inc: store.initialized && store.isWorking()
                        ? null
                        : store.incTempoTrabalho,
                    dec: store.initialized && store.isWorking()
                        ? null
                        : store.decTempoTrabalho,
                  ),
                  TimeInput(
                    valor: store.tempoDescanso,
                    titulo: 'Descanso',
                    inc: store.initialized && store.isResting()
                        ? null
                        : store.incTempoDescanso,
                    dec: store.initialized && store.isResting()
                        ? null
                        : store.decTempoDescanso,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
