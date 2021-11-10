import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:shop/errors/http_exception.dart';
import 'package:shop/providers/product.dart';

class Products with ChangeNotifier {
  List<Product> _products;
  final _urlproducts = '${dotenv.env['API_BASE']}/products';
  final _urlUserFavorites = '${dotenv.env['API_BASE']}/userFavorites';

  final String _token;
  final String _userId;

  Products([this._token = '', this._userId = '', this._products = const []]);

  List<Product> get products {
    return [..._products];
  }

  int get itemsCount {
    return _products.length;
  }

  Future<void> getProducts() async {
    List<Product> products = [];
    try {
      final response = await Dio().get('$_urlproducts.json?auth=$_token');
      if (response.data == null) return;
      //Map<String, dynamic> data = json.decode(response.body);

      final favoritesResp = await Dio().get(
        '$_urlUserFavorites/$_userId.json?auth=$_token',
      );
      if (favoritesResp.data == null) return;

      response.data.forEach((prodId, prodData) {
        final bool isFavourite = favoritesResp.data[prodId] ?? false;

        products.add(
          Product(
              id: prodId,
              name: prodData['name'],
              description: prodData['description'],
              price: double.parse(prodData['price'].toString()),
              imageUrl: prodData['imageUrl'],
              isFavotire: isFavourite),
        );
      });
      _products = products;
      notifyListeners();
    } catch (error) {
      // ignore: avoid_print
      print(error);
    }
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
      '$_urlproducts.json?auth=$_token',
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
      '$_urlproducts/${product.id}.json?auth=$_token',
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
    try {
      await dio.delete(
        '$_urlproducts/$productId.json?auth=$_token',
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
