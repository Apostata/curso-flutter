import 'dart:async';
import 'package:mobx/mobx.dart';
part 'pomodore.store.g.dart';

class PomodoreStore = _PomodoreStore with _$PomodoreStore;

enum IntervalType { WORK, REST }

abstract class _PomodoreStore with Store {
  @observable
  IntervalType intervalType = IntervalType.WORK;

  @observable
  int tempoTrabalho = 2;

  @observable
  int tempoDescanso = 1;

  @observable
  int minutes = 2;

  @observable
  int seconds = 0;

  @observable
  bool initialized = false;

  Timer? timer;

  @action
  void startTimer() {
    initialized = true;
    timer = Timer.periodic(
      const Duration(milliseconds: 50),
      (timer) {
        if (minutes == 0 && seconds == 0) {
          _changeIntervalType();
        }
        if (seconds == 0) {
          seconds = 59;
          minutes--;
        } else {
          seconds--;
        }
      },
    );
  }

  @action
  void stopTimer() {
    initialized = false;
    timer?.cancel();
  }

  @action
  void refreshTimer() {
    initialized = false;
    stopTimer();
    minutes = isWorking() ? tempoTrabalho : tempoDescanso;
    seconds = 0;
  }

  @action
  void incTempoTrabalho() {
    tempoTrabalho++;
    if (isWorking()) {
      refreshTimer();
    }
  }

  @action
  void incTempoDescanso() {
    tempoDescanso++;
    if (isResting()) {
      refreshTimer();
    }
  }

  @action
  void decTempoTrabalho() {
    if (tempoTrabalho > 1) {
      tempoTrabalho--;
    }
    if (isWorking()) {
      refreshTimer();
    }
  }

  @action
  void decTempoDescanso() {
    if (tempoDescanso > 1) {
      tempoDescanso--;
    }
    if (isResting()) {
      refreshTimer();
    }
  }

  bool isWorking() {
    return intervalType == IntervalType.WORK;
  }

  bool isResting() {
    return intervalType == IntervalType.REST;
  }

  void _changeIntervalType() {
    if (isWorking()) {
      intervalType = IntervalType.REST;
      minutes = tempoDescanso;
    } else {
      intervalType = IntervalType.WORK;
      minutes = tempoTrabalho;
    }
    seconds = 0;
  }
}
