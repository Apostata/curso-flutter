import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class Products with ChangeNotifier {
  final List<Product> _products = dummyProducts;

  List<Product> get products {
    return [..._products];
  }

  int get itemsCount {
    return _products.length;
  }

  List<Product> get favouriteProducts {
    return _products.where((prd) => prd.isFavotire).toList();
  }

  void saveProPrduct(Map<String, Object> _formData) {
    String id = _formData['id'] != null
        ? _formData['id'] as String
        : Random().nextDouble().toString();

    final product = Product(
      id: id,
      name: _formData['name'] as String,
      description: _formData['description'] as String,
      price: _formData['price'] as double,
      imageUrl: _formData['imageUrl'] as String,
    );

    if (_formData['id'] != null) {
      updateProduct(product);
    } else {
      addProduct(product);
    }
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void updateProduct(Product product) {
    final productIndex = _products.indexWhere((prod) => prod.id == product.id);
    if (productIndex >= 0) {
      _products[productIndex] = product; //update
      notifyListeners();
    }
  }

  void removeProduct(String productId) {
    _products.removeWhere((prod) => prod.id == productId);
    notifyListeners();
  }
}
