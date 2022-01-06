import 'package:campo_minado/models/tabuleiro.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('Tabuleiro', () {
    test('Ganhar jogo', () {
      Tabuleiro tabuleiro = Tabuleiro(linhas: 2, colunas: 2, qtdeBombas: 0);
      tabuleiro.campos[0].minar();
      tabuleiro.campos[3].minar();

      tabuleiro.campos[0].toggleMarcacao();
      tabuleiro.campos[1].abrir();
      tabuleiro.campos[2].abrir();
      tabuleiro.campos[3].toggleMarcacao();

      expect(tabuleiro.resolvido, isTrue);
    });
  });
}
