import 'package:flutter/material.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/orders_page.dart';
import 'package:shop/pages/product_item_page.dart';
import 'package:shop/pages/products_page.dart';
import 'package:shop/routes/routesPath.dart' as RoutesPath;

Map<String, Widget Function(BuildContext)> routes = {
  RoutesPath.HOME: (ctx) => const ProductsPage(),
  RoutesPath.PRODUCT_DETAIL: (ctx)=> const ProductDetailsPage(),
  RoutesPath.CART: (ctx) => const CartPage(),
  RoutesPath.ORDERS : (ctx) => const OrdersPage(),
};

Route<dynamic>? onGenerateRoutes(RouteSettings settings) {
  if (settings.name == '/xpto') {
    return MaterialPageRoute(builder: (_) => const ProductsPage());
  }
}

Route<dynamic> onUnknownRoute(RouteSettings settings) {
  return MaterialPageRoute(builder: (_) => const ProductsPage());
}
