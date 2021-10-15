import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class Products with ChangeNotifier {
  final List<Product> _products = dummyProducts;

  List<Product> get products {
    return [..._products];
  }

  List<Product> get favouriteProducts {
    return _products.where((prd) => prd.isFavotire).toList();
  }

  void addProPrduct(Product product) {
    _products.add(product);
    notifyListeners();
  }
}
