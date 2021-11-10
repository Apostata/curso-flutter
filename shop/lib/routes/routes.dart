import 'package:flutter/material.dart';
import 'package:regex_router/regex_router.dart';
import 'package:shop/pages/AuthOrHomePage.dart';
import 'package:shop/pages/Product_manager_page.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/orders_page_future.dart';
import 'package:shop/pages/product_item_page.dart';
import 'package:shop/pages/product_manager_edit_page.dart';
import 'package:shop/pages/products_page.dart';
import 'package:shop/routes/routesPath.dart' as RoutesPath;

final router = RegexRouter.create({
  // RoutesPath.AUTH: (ctx, _) => const AuthPage(),
  RoutesPath.AUTH_OR_HOME: (ctx, _) => const AuthOrHomePage(),
  RoutesPath.PRODUCT_DETAIL: (ctx, _) => const ProductDetailsPage(),
  // '${RoutesPath.PRODUCT_DETAIL}/:id': (ctx, args) => ProductDetailsPage(id: args['id']),
  RoutesPath.CART: (ctx, _) => const CartPage(),
  RoutesPath.ORDERS: (ctx, _) => const OrdersPageFuture(),
  RoutesPath.PRODUCTS: (ctx, _) => const ProductManagerPage(),
  '${RoutesPath.PRODUCTS}/:id': (ctx, args) => ProductManagerEdit(id: args['id'])
});

// Map<String, Widget Function(BuildContext)> routes = {
//   RoutesPath.HOME: (ctx) => const ProductsPage(),
//   RoutesPath.PRODUCT_DETAIL: (ctx)=> const ProductDetailsPage(),
//   RoutesPath.CART: (ctx) => const CartPage(),
//   RoutesPath.ORDERS : (ctx) => const OrdersPage(),
//   RoutesPath.PRODUCTS: (ctx) => const ProductManagerPage(),
//   RoutesPath.PRODUCT : (ctx) => const ProductManagerEdit(),
// };

// Route<dynamic>? onGenerateRoutes(RouteSettings settings) {
//   if (settings.name == '/xpto') {
//     return MaterialPageRoute(builder: (_) => const ProductsPage());
//   }

//   if (settings.name == '/product') {
//     return MaterialPageRoute(builder: (_) => const ProductsPage());
//   }
// }

final onGenerateRoutes = router.generateRoute;

Route<dynamic> onUnknownRoute(RouteSettings settings) {
  return MaterialPageRoute(builder: (_) => const ProductsPage());
}
