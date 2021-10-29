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
adicionar o provider ao main. Neste ponto criamos uma instância de `ChangeNotifierProvider` para o o provider `Produtos`.
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
```

### Re-renderizando stateless widgets utilizando provider
quando criamos um item builder passando um `ChangeNotiFierProvider`, este irá verificar qualquer alteração no indice do item em questão e se houver irá re-renderizar o child do item builder, que normalmente é um stateless widget

```dart
...
import 'package:provider/provider.dart';
import 'package:shop/providers/products.provider.dart';
import 'Product_item.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Products>(context);
    final products = provider.products;

    return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value( //passa produto via provider
          value: products[i],
          child: const ProductItem(),
        )
    );
  }
}
```

### Atualizar somente dados necessários do provider
No exemplo anterior de produto, somente o icone de coração altera, que é a propriedade `isFavourite` de `Product`

### Propriedade listen
o listen false serve para quando você não quer escutar as modificações no provider(dentro do metoto build do widget) ou para quando você chama o provider fora do metodo build do widget.
```dart
final product = Provider.of<Product>(
      context,
      listen: false
    );
```

### Usando o Consumer
para atualizar somente dados necesários. No exemplo anterior de produto, somente o icone de coração altera, que é a propriedade `isFavourite` de `Product` e colocar um `Consumer` somente no widget onde terá as alterações.


```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import '../routes//routes.dart' as Routes;

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final product = Provider.of<Product>(
      context,
      listen: false
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: ...,
        footer: GridTileBar(
          title: ...,
          backgroundColor: Colors.black54,
          leading: Consumer<Product>( //consumer para alteração apenas do IconButton
            builder:(contextConsumer, product, _) => 
              IconButton(
                icon: Icon( product.isFavotire == true ? Icons.favorite: Icons.favorite_border_outlined),
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () => {
                  product.toggleIsFavorite()
              },
            ),
          ),
          ...
        ),
      ),
    );
  }
}
```

#### Refatorando o provider e grid de produtos (Resolvendo problema com Key)
Como omo iremos reutilizar o grid tanto no catalogo da loja como no carrinho, mas o catalogo pode ou não mostrar os produtos favoritos, iremos refatorar algumas coias

Na página de catalogo, não usamos o provider, apenas no grid, porém é a página que passara o estado para renderizar ou não os favoritos apenas.
```dart
import 'package:flutter/material.dart';
import 'package:shop/Components/Product_grid.dart';

enum FilterOptions { Favourites, All }

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  bool showFavourites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha loja'),
        actions: [
          PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    const PopupMenuItem(
                      child: Text('Only Favourites'),
                      value: FilterOptions.Favourites,
                    ),
                    const PopupMenuItem(
                      child: Text('All'),
                      value: FilterOptions.All,
                    )
                  ],
              onSelected: (FilterOptions value) {
                setState(() {
                  showFavourites = value == FilterOptions.Favourites;
                });
              })
        ],
      ),
      body: ProductGrid(showFavourites),
    );
  }
}
```

No grid de produtos precisamos passar o boleano se é para mostrar ou não os favoritos e usar o provider para pega-los.
Como estamos alterando aa lista quando optamos em mostrar ou não os favoritos é **imprescindivel** passar uma `Key` para manter a referência, visto que a quantidade de produtos podem alterar e a lista pode perder a rererência

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products.provider.dart';
import 'Product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavourites;
  const ProductGrid(this.showFavourites, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Products>(context);
    final products =
        showFavourites ? provider.favouriteProducts :  provider.products;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(
          key:ValueKey(products[i].id) //  passando key para o widget ProductItem
        ),
      )
    );
  }
}
```

na componente do produto específico, precisa receber essa key passada no construtor, por via de regra o Flutter recomenda por em todos widgets:

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import '../routes//routes.dart' as Routes;

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key); // key para o construtor

  @override
  Widget build(BuildContext context) {

    final product = Provider.of<Product>(
      context,
      listen: false
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              Routes.PRODUCT_DETAIL,
              arguments: product,
            );
          },
        ),
        footer: GridTileBar(
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            builder:(contextConsumer, product, _) => 
              IconButton(
                icon: Icon( product.isFavotire == true ? Icons.favorite: Icons.favorite_border_outlined),
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () => {
                  product.toggleIsFavorite()
              },
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () => {},
          ),
        ),
      ),
    );
  }
}

```

### Usando multiplos providers
```dart
..
import 'package:provider/provider.dart';
...

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProvider(create: (_) => Products()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Orders()),
      ],
      child: MaterialApp(
        ...
      ),
    );
  }
}
```

### Provider dependente de outro
Quando um provider depende de outro é legal também passar o estado antigo do que precisa que atualize no provider dependente
```dart
..
import 'package:provider/provider.dart';
...

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products('', []), //qaundo inicia o app
          update: (ctx, auth, previous) { //quanto recebe novo valor de Auth
            return Products(auth.token ?? '', previous?.products ?? []);
          },
        ),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Orders()),
      ],
      child: MaterialApp(
        ...
      ),
    );
  }
}
```

