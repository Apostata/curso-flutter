# MobX
Similar ao redux, usa padrão observable

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