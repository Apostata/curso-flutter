import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shop/errors/http_exception.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/order.dart';
import 'cart.provider.dart';

class Orders with ChangeNotifier {
  final List<Order> _items = [];
  final _url = '${dotenv.env['API_BASE']}/orders';

  List<Order> get items {
    return [..._items];
  }

  Future<void> getOrders() async {
    _items.clear();
    final response = await Dio().get('$_url.json');

    response.data.forEach((orderId, orderData) {
      final id = orderId;
      _items.add(
        Order(
          id: id,
          total: orderData['total'],
          products: (orderData['products'] as List<dynamic>).map((cartItem)=>
            CartItem(
              id: cartItem['id'],
              productId: cartItem['productId'],
              name: cartItem['name'], 
              quantity: cartItem['quantity'], 
              price: cartItem['price'],
            )
          ).toList(),
          date: DateTime.parse(orderData['date']),
        ),
      );
    });
    notifyListeners();
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    try {
      final response = await Dio().post('$_url.json', data: {
        'total': cart.totalCart,
        'date': date.toIso8601String(),
        'products':
            cart.items.values.map((cartItem) => cartItem.itemToJson).toList()
      });
      final id = response.data['name'];

      _items.insert(
        0,
        Order(
            id: id,
            total: cart.totalCart,
            date: DateTime.now(),
            products: cart.items.values.toList()),
      );
      notifyListeners();
    } catch (error) {
      throw HttpException(
        message: 'Não foi possível realizar seu pedido!',
      );
    }
  }
}