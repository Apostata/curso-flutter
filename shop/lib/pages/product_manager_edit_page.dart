import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/providers/products.provider.dart';
import '../routes/routesPath.dart' as RoutesPath;

class ProductManagerEdit extends StatefulWidget {
  final String? id;

  const ProductManagerEdit({Key? key, this.id = 'new'}) : super(key: key);

  @override
  State<ProductManagerEdit> createState() => _ProductManagerEditState();
}

class _ProductManagerEditState extends State<ProductManagerEdit> {
  Product? product;
  bool isEdit = false;

  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();

  final _idControler = TextEditingController();
  final _nameControler = TextEditingController();
  final _priceControler = TextEditingController();
  final _descriptionControler = TextEditingController();
  final _imageUrlControler = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  bool _isLoading = false;

  bool isValidUrl(String url) {
    final urlRegex = RegExp(
        r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");
    return urlRegex.hasMatch(url);
  }

  @override
  Widget? initState() {
    super.initState();
    final id = widget.id;

    if (id != null && id != 'new') {
      final products = Provider.of<Products>(context, listen: false);
      final selectedProd = products.products.where((prd) {
        return prd.id == id;
      }).toList();

      if (selectedProd.isNotEmpty) {
        setState(() {
          product = selectedProd[0];
          isEdit = true;
        });
        _idControler.text = product?.id.toString() ?? '';
        _nameControler.text = product?.name.toString() ?? '';
        _priceControler.text = product?.price.toStringAsFixed(2) ?? '';
        _descriptionControler.text = product?.description ?? '';
        _imageUrlControler.text = product?.imageUrl ?? '';
        _formData['id'] = product?.id.toString() ?? '';
      } else {
        Navigator.of(context).pushReplacementNamed(RoutesPath.PRODUCTS);
      }
    }

    _imageUrlFocus.addListener(updateImage);
  }

  void updateImage() {
    if (isValidUrl(_imageUrlControler.text)) {
      setState(() {});
    }
  }

  void _submitForm() async {
    _formKey.currentState?.save();
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Products>(context, listen: false)
          .saveProPrduct(_formData);
      Navigator.of(context).pop();
    } catch (error) {
      print(error);
      await showDialog(
          context: context,
          builder: (modalCtx) => AlertDialog(
                title: const Text('cocrreu um erro'),
                content: const Text('Ocorreu um erro ao salvar o produto!'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'))
                ],
              ));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final id = widget.id;

    return Scaffold(
      appBar: AppBar(
        title: Text(id != 'new' ? 'Editar Produto' : 'Novo Produto'),
        actions: [
          IconButton(onPressed: _submitForm, icon: const Icon(Icons.send))
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    id != 'new'
                        ? TextFormField(
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: 'ID',
                            ),
                            controller: _idControler,
                            textInputAction: TextInputAction.next,
                          )
                        : const SizedBox(
                            width: 0,
                            height: 0,
                          ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                      ),
                      textInputAction: TextInputAction.next,
                      controller: _nameControler,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocus);
                      },
                      onSaved: (name) => _formData['name'] = name ?? '',
                      validator: (_name) {
                        final name = _name ?? '';

                        if (name.trim().isEmpty) {
                          return 'Nome é obrigatório';
                        }
                        if (name.trim().length < 3) {
                          return 'Nome deve ter ao menos 3 letras!';
                        }
                        return null;
                      },
                    ),
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
                        _formData['price'] = double.tryParse(price!) ?? 0;
                      },
                      validator: (_price) {
                        final double price = double.tryParse(_price!) ?? -1;
                        if (price <= 0) {
                          return 'Preço precisa ser um número maior que 0!';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Descrição',
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      controller: _descriptionControler,
                      focusNode: _descriptionFocus,
                      validator: (_description) {
                        final description = _description ?? '';

                        if (description.trim().isEmpty) {
                          return 'Descrição é obrigatória';
                        }
                        if (description.trim().length < 10) {
                          return 'Descrição deve ter ao menos 10 letras!';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_imageUrlFocus);
                      },
                      onSaved: (description) =>
                          _formData['description'] = description ?? '',
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Url da Imagem',
                            ),
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.url,
                            controller: _imageUrlControler,
                            focusNode: _imageUrlFocus,
                            onFieldSubmitted: (_) => _submitForm(),
                            onSaved: (imageUrl) => {
                              _formData['imageUrl'] = imageUrl ?? '',
                            },
                            validator: (_imageUrl) {
                              final imageUrl = _imageUrl ?? '';
                              if (!isValidUrl(imageUrl)) {
                                return 'Url da imagem é inválida!';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.fromLTRB(15, 15, 0, 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1)),
                          child: _imageUrlControler.text.isEmpty ||
                                  !isValidUrl(_imageUrlControler.text)
                              ? const Text(
                                  'Informe a URL',
                                  style: TextStyle(fontSize: 12),
                                )
                              : Image.network(
                                  _imageUrlControler.text,
                                  width: 100,
                                  height: 100,
                                ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
