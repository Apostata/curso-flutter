import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/providers/cart.provider.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  const CartItemWidget(
    this.cartItem, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 15),
      ),
      child: Card(
        color: const Color.fromARGB(255, 255, 255, 255),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: Text('R\$${cartItem.price}'),
              ),
            ),
          ),
          title: Text(cartItem.name),
          subtitle: Text('R\$${cartItem.quantity * cartItem.price}'),
          trailing: Text('${cartItem.quantity}'),
        ),
      ),
      confirmDismiss: (_) {
        return showDialog(
          context: context,
          builder: (modalCtx) => AlertDialog(
            title: const Text('Remover do carrinho?'),
            content: const Text('Realmente deseja remover o item do carrinho?'),
            actions: [
              TextButton(
                child: const Text('NÃO'),
                onPressed: () {
                  Navigator.of(modalCtx).pop(false);
                },
              ),
              TextButton(
                child: const Text('SIM'),
                onPressed: () {
                  Navigator.of(modalCtx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (_) {
        Provider.of<Cart>(
          context,
          listen: false,
        ).removeItems(cartItem.productId);
      },
    );
  }
}
