import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/cart.provider.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({
    Key? key, String? id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                product.name,
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: product.id,
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0, 1),
                        end: Alignment(0, 0),
                        colors: [
                          Color.fromRGBO(0, 0, 0, 0.6),
                          Color.fromRGBO(0, 0, 0,0)
                        ]
                      )
                    ),
                  )
                ],
              )
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
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
              ),
              const SizedBox(height: 800,)
            ]),
          ),
        ],
      ),
    );
  }
}
