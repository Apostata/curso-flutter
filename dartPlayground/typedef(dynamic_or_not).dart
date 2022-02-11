abstract class Teste {
  dynamic get param;
  Teste();
  void log() {
    print(param);
  }
}

class Teste1 extends Teste {
  @override
  final dynamic param;
  Teste1(this.param);
}

typedef TypeDefSample = Teste Function(dynamic valor);

void main() {
  TypeDefSample teste = (dynamic oples) {
    return Teste1(oples);
  };

  // Teste teste(dynamic oples) => Teste1(oples);

// esse teste consiste em instanciar uma classe filha e ter o retorno com o tipo do pai
// permitindo assim algo similar a uma chamada dinâmica passando parametros

  teste.call(23).log(); //pode ser chamado com call ou sem
  teste('wewe').log();
}
