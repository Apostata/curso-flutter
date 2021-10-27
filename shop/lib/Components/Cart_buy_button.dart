import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/errors/http_exception.dart';
import 'package:shop/providers/cart.provider.dart';
import 'package:shop/providers/orders.provider.dart';

class CartBuyButton extends StatefulWidget {
  final Cart cart;
  const CartBuyButton({Key? key, required this.cart}) : super(key: key);

  @override
  State<CartBuyButton> createState() => _CartBuyButtonState();
}

class _CartBuyButtonState extends State<CartBuyButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final cart = widget.cart;
    final isCartEmpty = cart.productsCount < 1;

    return TextButton(
      onPressed: isCartEmpty || _isLoading
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              try {
                await Provider.of<Orders>(context, listen: false)
                    .addOrder(cart);
                cart.cleanItems();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Compra Realizada com sucesso')
                  )
                );
                setState(() {
                _isLoading = false;
              });
              } on HttpException catch (error) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(error.toString())));
              }
            },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Text(
              'COMPRAR',
              style: TextStyle(
                color: isCartEmpty || _isLoading
                  ? Theme.of(context).disabledColor
                  : Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          if(_isLoading) const Positioned(
            right: 0,
            top: 0,
            child: SizedBox(
              width: 15,
              height: 1,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: CircularProgressIndicator()
              )
            )
          )
        ]
      ),
    );
  }
}
