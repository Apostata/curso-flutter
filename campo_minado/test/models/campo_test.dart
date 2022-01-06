import 'package:campo_minado/models/campo.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('Campo', () {
    test('Abrir campo COM explosão', () {
      Campo campo = Campo(linha: 0, coluna: 0);
      campo.minar();

      expect(campo.abrir, throwsException);
      // ou
      // expect(() => campo.abrir(), throwsException);
    });

    test('Abrir campo SEM explosão', () {
      Campo campo = Campo(linha: 0, coluna: 0);
      campo.abrir();

      expect(campo.aberto, isTrue);
    });

    test('Adicionar NÃO vizinho', () {
      Campo campo1 = Campo(linha: 0, coluna: 0);
      Campo campo2 = Campo(linha: 1, coluna: 3);
      campo1.addVizinho(campo2);

      expect(campo1.vizinhos.isEmpty, isTrue);
    });

    test('Adicionar vizinho', () {
      Campo campo = Campo(linha: 3, coluna: 3);
      Campo vizinho1 = Campo(linha: 2, coluna: 2);
      Campo vizinho2 = Campo(linha: 2, coluna: 3);
      Campo vizinho3 = Campo(linha: 2, coluna: 4);
      Campo vizinho4 = Campo(linha: 3, coluna: 2);
      Campo vizinho5 = Campo(linha: 3, coluna: 4);
      Campo vizinho6 = Campo(linha: 4, coluna: 2);
      Campo vizinho7 = Campo(linha: 4, coluna: 3);
      Campo vizinho8 = Campo(linha: 4, coluna: 4);
      Campo vizinho9 = Campo(linha: 4, coluna: 5);

      campo.addVizinho(vizinho1);
      campo.addVizinho(vizinho2);
      campo.addVizinho(vizinho3);
      campo.addVizinho(vizinho4);
      campo.addVizinho(vizinho5);
      campo.addVizinho(vizinho6);
      campo.addVizinho(vizinho7);
      campo.addVizinho(vizinho8);
      campo.addVizinho(vizinho9);

      expect(campo.vizinhos.length, 8);
    });

    test('Minas na vizinhança', () {
      Campo campo = Campo(linha: 3, coluna: 3);
      Campo vizinho1 = Campo(linha: 2, coluna: 2);
      Campo vizinho2 = Campo(linha: 2, coluna: 3);
      Campo vizinho3 = Campo(linha: 2, coluna: 4);
      Campo vizinho4 = Campo(linha: 3, coluna: 2);
      vizinho1.minar();
      vizinho4.minar();
      campo.addVizinho(vizinho1);
      campo.addVizinho(vizinho2);
      campo.addVizinho(vizinho3);
      campo.addVizinho(vizinho4);

      expect(campo.qtdeMinasVizinhanca, 2);
    });
  });
}
