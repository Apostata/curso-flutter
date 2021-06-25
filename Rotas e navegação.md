# Navegação entre páginas ou telas

## Metodo simplório
No componente o qual terá um click ou um tap, importar a página para a qual ele erá direcionar, na função relacionada ao click ou tap chamar no navigator:

```dart
...
import '../pages/categories_food_page.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem(this.category);

  void _selectCatetory(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return CategoriesFoodPage(); // também tem o cupertino page router
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectCatetory(context),
      borderRadius: BorderRadius.circular(15),
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        ...
      ),
    );
  }
}

```

## Rotas nomeadas
Definidas no main.dart ou outro arquivo:
```dart
...

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FodApp',
      theme: ThemeData(
        ...
      ),
      home: CategoryPage(),
      routes: {
        '/categories-food': (ctx) => CategoriesFoodPage(),
      },
    );
  }
}

```
no arquivo que chamará uma rota, este passa categoria como parametro para a página `categories-food`:

```dart
class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem(this.category);

void _selectCatetory(BuildContext context) {
    Navigator.of(context).pushNamed(
      '/categories-food',
      arguments: category,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectCatetory(context),
      borderRadius: BorderRadius.circular(15),
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        ...
      ),
    );
  }
}
```
recebendo o parametro passado pela rota:

```dart
import 'package:flutter/material.dart';
import 'package:food_app/models/category.dart';

class CategoriesFoodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final category = ModalRoute.of(context)!.settings.arguments as Category;//recebendo da rota

    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: Center(
        child: Text('receitas por categoria:${category.id}'),
      ),
    );
  }
}

```