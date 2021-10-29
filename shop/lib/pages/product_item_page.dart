import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Components/AppbarCartActionButton.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/cart.provider.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(product.name),
        actions: const [AppbarCartActionButton()],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              height: 300,
              width: double.infinity,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              'R\$${product.price}',
              style: TextStyle(color: Colors.grey[700], fontSize: 20),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                product.description,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 250,
              child: Consumer<Cart>(
                builder: (contextConsumer, cart, _) => ElevatedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('COMPRAR'),
                        Icon(Icons.shopping_bag_outlined)
                      ],
                    ),
                  ),
                  onPressed: () {
                    cart.addItem(product);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Produto "${product.name}" adicionado com sucesso!'),
                        duration: const Duration(seconds: 3),
                        action: SnackBarAction(
                          label: 'DESFAZER',
                          onPressed: () {
                            cart.removeSingleItem(product.id);
                          },
                        ),
                      )
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
