# Formulario

Trabalhando com formulários no flutter

```dart
class ProductManagerEdit extends StatefulWidget {
  final String? id;

  const ProductManagerEdit({Key? key, this.id = 'new'}) : super(key: key);

  @override
  State<ProductManagerEdit> createState() => _ProductManagerEditState();
}

 void updateImage() {
    setState(() {});
  }

class _ProductManagerEditState extends State<ProductManagerEdit> {
    ...
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  final _priceFocus = FocusNode();
    ...

  final _priceControler = TextEditingController();
    ...
  

@override
  Widget? initState() {
    super.initState();

    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void dispose() {
    super.dispose();
    ...
    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  void _submitForm() {
    _formKey.currentState?.save();
    String id = !isEdit ? Random().nextDouble().toString() : product!.id;
    final newProroduct = Product(
      id: id,
      name: _formData['name'] as String,
      description: _formData['description'] as String,
      price: _formData['price'] as double,
      imageUrl: _formData['imageUrl'] as String,
    );
    print(newProroduct.id);
    print(newProroduct.name);
    print(newProroduct.description);
    print(newProroduct.price);
    print(newProroduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    final id = widget.id;

    return Scaffold(
      ...
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              ...
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Preço',
                ),
                textInputAction: TextInputAction.next,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                controller: _priceControler,
                focusNode: _priceFocus,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
                onSaved: (price) {
                  _formData['price'] = price =='' ? 0.0 : double.parse(price!);
                },
              ),
                ...
            ],
          ),
        ),
      ),
    );
  }
}

```

## Chave do formulário

É preciso criar uma referencia para acessar os estados do formulários e linka-la com widget de formulário 

```dart
class _ProductManagerEditState extends State<ProductManagerEdit> {
    ...
  final _formKey = GlobalKey<FormState>(); //chave do formulario

  @override
  Widget build(BuildContext context) {
    final id = widget.id;

    return Scaffold(
      ...
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Form(
          key: _formKey, //link entre chave e widget do formulário
          child: ListView(
              ...
          )
        )
      )
  }
...
```

## adicionando controllers aos inputs
para controlar as mudanças em cada input é necessário criar um controller para cada um

```dart
class _ProductManagerEditState extends State<ProductManagerEdit> {
    ...
  final _formKey = GlobalKey<FormState>(); //chave do formulario

  @override
  Widget build(BuildContext context) {
    final id = widget.id;

    return Scaffold(
      ...
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Form(
          key: _formKey, //link entre chave e widget do formulário
          child: ListView(
              ...
          )
        )
      )
  }
...
```