import 'package:flutter/material.dart';
import 'answer.dart';
import 'question.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> perguntas;
  final int perguntaSelecionada;
  final void Function(int) responder;

  Quiz({
    @required this.perguntas,
    @required this.perguntaSelecionada,
    @required this.responder,
  });

  bool get hasSelectedQuestion {
    return perguntaSelecionada < perguntas.length;
  }

  Iterable<Widget> _getAnswers() {
    List<Map<String, Object>> respostasList =
        perguntas[perguntaSelecionada]['respostas'];

    Iterable<Widget> respostas = hasSelectedQuestion
        ? respostasList.asMap().entries.map((item) => Answer(
            item.value['texto'],
            (item.key + 1),
            () => responder(item.value['valor'])))
        : null;
    return respostas;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Questao(perguntas[perguntaSelecionada]['pergunta']),
        ..._getAnswers()
      ],
    );
  }
}
