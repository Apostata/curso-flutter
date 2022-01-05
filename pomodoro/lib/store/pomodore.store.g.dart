// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pomodore.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PomodoreStore on _PomodoreStore, Store {
  final _$intervalTypeAtom = Atom(name: '_PomodoreStore.intervalType');

  @override
  IntervalType get intervalType {
    _$intervalTypeAtom.reportRead();
    return super.intervalType;
  }

  @override
  set intervalType(IntervalType value) {
    _$intervalTypeAtom.reportWrite(value, super.intervalType, () {
      super.intervalType = value;
    });
  }

  final _$tempoTrabalhoAtom = Atom(name: '_PomodoreStore.tempoTrabalho');

  @override
  int get tempoTrabalho {
    _$tempoTrabalhoAtom.reportRead();
    return super.tempoTrabalho;
  }

  @override
  set tempoTrabalho(int value) {
    _$tempoTrabalhoAtom.reportWrite(value, super.tempoTrabalho, () {
      super.tempoTrabalho = value;
    });
  }

  final _$tempoDescansoAtom = Atom(name: '_PomodoreStore.tempoDescanso');

  @override
  int get tempoDescanso {
    _$tempoDescansoAtom.reportRead();
    return super.tempoDescanso;
  }

  @override
  set tempoDescanso(int value) {
    _$tempoDescansoAtom.reportWrite(value, super.tempoDescanso, () {
      super.tempoDescanso = value;
    });
  }

  final _$minutesAtom = Atom(name: '_PomodoreStore.minutes');

  @override
  int get minutes {
    _$minutesAtom.reportRead();
    return super.minutes;
  }

  @override
  set minutes(int value) {
    _$minutesAtom.reportWrite(value, super.minutes, () {
      super.minutes = value;
    });
  }

  final _$secondsAtom = Atom(name: '_PomodoreStore.seconds');

  @override
  int get seconds {
    _$secondsAtom.reportRead();
    return super.seconds;
  }

  @override
  set seconds(int value) {
    _$secondsAtom.reportWrite(value, super.seconds, () {
      super.seconds = value;
    });
  }

  final _$initializedAtom = Atom(name: '_PomodoreStore.initialized');

  @override
  bool get initialized {
    _$initializedAtom.reportRead();
    return super.initialized;
  }

  @override
  set initialized(bool value) {
    _$initializedAtom.reportWrite(value, super.initialized, () {
      super.initialized = value;
    });
  }

  final _$_PomodoreStoreActionController =
      ActionController(name: '_PomodoreStore');

  @override
  void startTimer() {
    final _$actionInfo = _$_PomodoreStoreActionController.startAction(
        name: '_PomodoreStore.startTimer');
    try {
      return super.startTimer();
    } finally {
      _$_PomodoreStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void stopTimer() {
    final _$actionInfo = _$_PomodoreStoreActionController.startAction(
        name: '_PomodoreStore.stopTimer');
    try {
      return super.stopTimer();
    } finally {
      _$_PomodoreStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void refreshTimer() {
    final _$actionInfo = _$_PomodoreStoreActionController.startAction(
        name: '_PomodoreStore.refreshTimer');
    try {
      return super.refreshTimer();
    } finally {
      _$_PomodoreStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incTempoTrabalho() {
    final _$actionInfo = _$_PomodoreStoreActionController.startAction(
        name: '_PomodoreStore.incTempoTrabalho');
    try {
      return super.incTempoTrabalho();
    } finally {
      _$_PomodoreStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incTempoDescanso() {
    final _$actionInfo = _$_PomodoreStoreActionController.startAction(
        name: '_PomodoreStore.incTempoDescanso');
    try {
      return super.incTempoDescanso();
    } finally {
      _$_PomodoreStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decTempoTrabalho() {
    final _$actionInfo = _$_PomodoreStoreActionController.startAction(
        name: '_PomodoreStore.decTempoTrabalho');
    try {
      return super.decTempoTrabalho();
    } finally {
      _$_PomodoreStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decTempoDescanso() {
    final _$actionInfo = _$_PomodoreStoreActionController.startAction(
        name: '_PomodoreStore.decTempoDescanso');
    try {
      return super.decTempoDescanso();
    } finally {
      _$_PomodoreStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
intervalType: ${intervalType},
tempoTrabalho: ${tempoTrabalho},
tempoDescanso: ${tempoDescanso},
minutes: ${minutes},
seconds: ${seconds},
initialized: ${initialized}
    ''';
  }
}
