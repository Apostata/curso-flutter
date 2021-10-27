import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:shop/errors/http_exception.dart';
import 'package:shop/models/product.dart';

class Products with ChangeNotifier {
  final List<Product> _products = [];
  final _url = '${dotenv.env['API_BASE']}/products';

  List<Product> get products {
    return [..._products];
  }

  int get itemsCount {
    return _products.length;
  }

  Future<void> getProducts() async {
    _products.clear();
    final response = await Dio().get('$_url.json');
    if (response.data == null) return;
    //Map<String, dynamic> data = json.decode(response.body);
    response.data.forEach((prodId, prodData) {
      _products.add(
        Product(
          id: prodId,
          name: prodData['name'],
          description: prodData['description'],
          price: double.parse(prodData['price'].toString()),
          imageUrl: prodData['imageUrl'],
          isFavotire: prodData['isFavorite'],
        ),
      );
    });
    notifyListeners();
  }

  List<Product> get favouriteProducts {
    return _products.where((prd) => prd.isFavotire).toList();
  }

  Future<void> saveProPrduct(Map<String, Object> _formData) {
    final id = _formData['id'] as String? ?? '';

    final product = Product(
      id: id,
      name: _formData['name'] as String,
      description: _formData['description'] as String,
      price: _formData['price'] as double,
      imageUrl: _formData['imageUrl'] as String,
    );

    if (_formData['id'] != null) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(Product product) async {
    final response = await Dio().post(
      '$_url.json',
      data: {
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'isFavorite': product.isFavotire
      },
    );

    final String id = response.data['name'];

    _products.add(
      Product(
        id: id,
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        isFavotire: product.isFavotire,
      ),
    );
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    final productIndex = _products.indexWhere((prod) => prod.id == product.id);
    if (productIndex < 0) return;
    // _products[productIndex] = product; //update
    await Dio().patch(
      '$_url/${product.id}.json',
      data: {
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
      },
    );
    _products[productIndex] = product; //update
    notifyListeners();
  }

  Future<void> removeProduct(String productId) async {
    final productIndex = _products.indexWhere((prod) => prod.id == productId);
    if (productIndex < 0) return;

    final product = _products[productIndex];

    _products.removeWhere((prod) => prod.id == productId);
    notifyListeners();
    final dio = Dio();
    Response<void>? response;
    try {
      response = await dio.delete(
        '$_url/$productId.json',
      );
    } catch (error) {
      _products.insert(productIndex, product);
      notifyListeners();
      throw HttpException(
        message: 'Não foi Possivel excluir o produto ${product.name}!',
      );
    }
  }
}
