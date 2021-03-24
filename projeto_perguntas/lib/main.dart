import 'package:flutter/material.dart';
import 'result.dart';
import 'quiz.dart';

main(List<String> args) => runApp(AsksAndQuestionsApp());

class _QuestionAppState extends State<AsksAndQuestionsApp> {
  int _perguntaSelecionada = 0;
  int _score = 0;
  final List<Map<String, Object>> _perguntas = [
    {
      'pergunta': 'Qual é a sua cor favorita?',
      'respostas': [
        {'texto': 'Preto', 'valor': 5},
        {'texto': 'Vermelho', 'valor': 3},
        {'texto': 'Verde', 'valor': 10},
        {'texto': 'Roxo', 'valor': 1},
      ]
    },
    {
      'pergunta': 'Qual o seu animal favorito?',
      'respostas': [
        {'texto': 'Cachorro', 'valor': 5},
        {'texto': 'Gato', 'valor': 3},
        {'texto': 'Rato', 'valor': 10},
        {'texto': 'Morcego', 'valor': 1},
      ]
    },
    {
      'pergunta': 'Qual sua linguagem favorira?',
      'respostas': [
        {'texto': 'Dart', 'valor': 5},
        {'texto': 'Java', 'valor': 3},
        {'texto': 'Javascript', 'valor': 10},
        {'texto': 'C#', 'valor': 1},
      ]
    }
  ];

  void _responder(int valor) {
    if (hasSelectedQuestion) {
      setState(() {
        _perguntaSelecionada++;
        _score += valor;
      });
    }
  }

  void _reiniciar() {
    setState(() {
      _perguntaSelecionada = 0;
      _score = 0;
    });
  }

  bool get hasSelectedQuestion {
    return _perguntaSelecionada < _perguntas.length;
  }

  @override //anotation ou decorator
  Widget build(BuildContext context) {
    //composição
    return MaterialApp(
      home: Scaffold(
        //estrutura
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text('Aks and Questions'),
        ),
        body: hasSelectedQuestion
            ? Quiz(
                perguntas: _perguntas,
                perguntaSelecionada: _perguntaSelecionada,
                responder: _responder,
              )
            : Result(' sua pontuação final foi de: ', _score, _reiniciar),
      ),
    ); //cria uma instancia de MaterialApp
  }
}

class AsksAndQuestionsApp extends StatefulWidget {
  @override
  _QuestionAppState createState() {
    return _QuestionAppState();
  }
}
