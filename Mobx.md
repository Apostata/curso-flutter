# MobX
Similar ao redux, usa padrão observable

**Minha opinião**: implementação no Flutter parece gateada, mas é bem fácil de usar. Até então prefiro o Provider sozinho do que ter que adicionar mais 3 dependências


## Criando uma Store


```dart
import 'package:mobx/mobx.dart';
part 'contador.store.g.dart';

class ContadorStore = _ContadorStore with _$ContadorStore;

abstract class _ContadorStore with Store {
  @observable
  int contador = 0;

  @action
  void incrementar() {
    contador++;
  }
}

```
## implementando

flutter pub run build_runner clean
flutter pub run build_runner watch


```dart
...

final store = ContadorStore();

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        ...
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           ...
            Observer( // reage as alterações no observable = Subscriber
              builder: (_) => Text(
                '${store.contador}', 
                style: Theme.of(context).textTheme.headline4,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: store.incrementar, //chama a action do observable
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

```

para melhorar o tempo do build do commando watch, criar um arquivo `build.yaml`, restringindo assim as pastas que o watch irá procurar na raiz:
```yaml
targets:
  $default:
    builders:
      mobx_codegen|mobx_generator:
        generate_for:
          - "lib/store/**.store.dart"
```