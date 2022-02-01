import 'dart:math';

import 'package:campo_minado/models/campo.dart';

class Tabuleiro {
  final int linhas;
  final int colunas;
  final int qtdeBombas;

  final List<Campo> _campos = [];

  Tabuleiro({
    required this.linhas,
    required this.colunas,
    required this.qtdeBombas,
  }) {
    _criarCampos();
    _relacionarVizinhos();
    _sortearMinas();
  }

  void reiniciar() {
    for (Campo campo in _campos) {
      campo.reiniciar();
    }
    _sortearMinas();
  }

  void _criarCampos() {
    for (int lin = 0; lin < linhas; lin++) {
      for (int col = 0; col < colunas; col++) {
        _campos.add(Campo(linha: lin, coluna: col));
      }
    }
  }

  void _relacionarVizinhos() {
    for (Campo campo in _campos) {
      for (Campo vizinho in _campos) {
        campo.addVizinho(vizinho);
      }
    }
  }

  void _sortearMinas() {
    int sorteadas = 0;

    if (qtdeBombas > linhas * colunas) {
      throw Exception();
      // return;
    }

    while (sorteadas < qtdeBombas) {
      int i = Random().nextInt(_campos.length);
      if (!_campos[i].minado) {
        sorteadas++;
        _campos[i].minar();
      }
    }
  }

  void revelarBombas() {
    for (Campo campo in _campos) {
      campo.revelarBomba();
    }
  }

  List<Campo> get campos {
    return _campos;
  }

  bool get resolvido {
    return _campos.every((campo) => campo.resolvido);
  }
}
