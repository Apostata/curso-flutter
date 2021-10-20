import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/order.dart';

import 'cart.provider.dart';

class Orders with ChangeNotifier {
  final List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  void addOrder(Cart cart) {
    _items.insert(
      0,
      Order(
          id: Random().nextDouble().toString(),
          total: cart.totalCart,
          date: DateTime.now(),
          products: cart.items.values.toList()),
    );
    notifyListeners();
  }
}
