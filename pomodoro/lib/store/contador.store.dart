import 'package:mobx/mobx.dart';
part 'contador.store.g.dart';

class ContadorStore = _ContadorStore with _$ContadorStore;
// _$Contadorstore é gerado pelo mobx_codegen + build runner

// A sintaxe abaixo não existe nativamente no dart, e será gerada
// pelo mobx_codegen + build_runner
abstract class _ContadorStore with Store {
  @observable
  int contador = 0;

  @action
  void incrementar() {
    contador++;
  }
}
