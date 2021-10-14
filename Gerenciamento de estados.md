# Gerenciamento de estado entre componentes

## usando inherited Widget
Criando um inheritedWidget provider:

O inherited widget precisa **Sempre** receber um widget como parametro, e precisa ter uma função `updateShouldNotify`, para avisar os componentes quando devem ser atualizados. O método `of` aqui vai retornar a instancia de CounterProvider relativo ao contexto, por essa razão o componente que o implementar necessitará ser um `statefullWidget`, para que sempre possa atualizar o estado dependendo das alterações no contexto
```dart
import 'package:flutter/material.dart';

class CounterState {
  int _value = 0;

  void add() => _value++;
  void remove() => _value--;

  int get value => _value;

  bool diff(CounterState old) {
    return old._value != value;
  }
}

class CounterProvider extends InheritedWidget {
  final CounterState state = CounterState();
  CounterProvider({Key? key, required Widget child})
      : super(key: key, child: child);

  static CounterProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  @override
  bool updateShouldNotify(covariant CounterProvider oldWidget) {
    return oldWidget.state.diff(state);
  }
}
```

colocando no main.dart:
```dart
...
import 'package:shop/Providers/counter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CounterProvider(
      child: MaterialApp(
        ...
      ),
    );
  }
}
```

e então no widget a ser utilizado:


## usando o provider

### instalando
pacote provider: https://pub.dev/packages/provider

adicionando pacote: `flutter pub add provider`

adicione ao `pubspec.yaml`:
```yaml
dependencies:
    ...
  provider: ^6.0.1
```
### implementação
Criando um provider:
```dart
import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class Products with ChangeNotifier {
  final List<Product> _products = dummyProducts;

  List<Product> get products => [..._products];

  void addProPrduct(Product product) {
    _products.add(product);
    notifyListeners();
  }
}
```
adicionar o provider ao main:
```dart
...
import 'package:provider/provider.dart';
import 'package:shop/providers/products.provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Products(), // products provider
      child: MaterialApp(
        ...
      ),
    );
  }
}
```
usando provider no componente:
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Components/Product_item.dart';
import 'package:shop/providers/products.provider.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Products>(context); //provider de produtos
    final products = provider.products; // pega produtos do provider

    return Scaffold(
      appBar: AppBar(title: const Text('Minha loja')),
      body: GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (ctx, i) => ProductItem(product: products[i])),
    );
  }
}

```dart