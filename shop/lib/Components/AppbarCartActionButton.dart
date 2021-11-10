import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.provider.dart';
import 'package:shop/routes/routesPath.dart' as RoutesPath;
import 'package:shop/Components/Badge.dart';

class AppbarCartActionButton extends StatelessWidget {
  const AppbarCartActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      child: IconButton(
        onPressed: () => {
          Navigator.of(context).pushNamed(
            RoutesPath.CART,
          )
        },
        icon: const Icon(Icons.shopping_cart)),
        builder: (ctxCart, cart, child) => Badge(
          child: child!,
          value: cart.productsCount.toString(),
        ),
    );
  }
}
