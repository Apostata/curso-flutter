import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Components/Cart_buy_button.dart';
import 'package:shop/Components/Cart_item.dart';
import 'package:shop/providers/auth.provider.dart';
import 'package:shop/providers/cart.provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final cartItems = cart.items.values.toList();

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.fromLTRB(15, 15, 15, 25),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'TOTAL:',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Chip(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      label: Text(
                        'R\$${cart.totalCart.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6
                              ?.color,
                        ),
                      )),
                  const Spacer(),
                  CartBuyButton(cart: cart)
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (lvbCtx, i) => CartItemWidget(
                      cartItems[i],
                      key: ValueKey(cartItems[i].id),
                    )),
          ),
        ],
      ),
    );
  }
}
