import 'package:campo_minado/components/resultado_widget.dart';
import 'package:campo_minado/components/tabuleiro_widget.dart';
import 'package:campo_minado/models/campo.dart';
import 'package:campo_minado/models/explosao_exception.dart';
import 'package:campo_minado/models/tabuleiro.dart';
import 'package:flutter/material.dart';

class CampoMinado extends StatefulWidget {
  const CampoMinado({Key? key}) : super(key: key);

  @override
  State<CampoMinado> createState() => _CampoMinadoState();
}

class _CampoMinadoState extends State<CampoMinado> {
  bool? _win;

  Tabuleiro? _tabuleiro;

  void _reiniciar() {
    setState(() {
      _tabuleiro?.reiniciar();
      _win = null;
    });
  }

  void _abrir(Campo campo) {
    if (_win != null) return;
    if (_tabuleiro != null) {
      setState(() {
        try {
          campo.abrir();
          if (_tabuleiro!.resolvido) {
            _win = true;
          }
        } on ExplosaoException {
          _win = false;
          _tabuleiro!.revelarBombas();
        }
      });
    }
  }

  void _toggleMarcacao(Campo campo) {
    if (_win != null) return;
    if (_tabuleiro != null) {
      setState(() {
        campo.toggleMarcacao();
        if (_tabuleiro!.resolvido) {
          _win = true;
        }
      });
    }
  }

  Tabuleiro _getTabuleiro(double largura, double altura) {
    if (_tabuleiro == null) {
      int qtdeColunas = 15;
      double tamanhoCampo = largura / qtdeColunas;
      int qtdeLinhas = (altura / tamanhoCampo).floor();

      int qdteBombas = (qtdeColunas * qtdeLinhas / 12).floor();
      _tabuleiro = Tabuleiro(
          linhas: qtdeLinhas,
          colunas: qtdeColunas,
          qtdeBombas: qdteBombas < 1 ? 1 : qdteBombas);
    }
    return _tabuleiro as Tabuleiro;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: ResultadoWidget(
            win: _win,
            onRestart: () => _reiniciar(),
          ),
          body: Container(
            color: Colors.grey,
            child: LayoutBuilder(
              builder: (ctx, constraints) {
                return TabuleiroWidget(
                  tabuleiro: _getTabuleiro(
                    constraints.maxWidth,
                    constraints.maxHeight,
                  ),
                  onOpen: _abrir,
                  onToggleMarcacao: _toggleMarcacao,
                );
              },
            ),
          )),
      debugShowCheckedModeBanner: false,
    );
  }
}
