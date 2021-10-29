import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/errors/http_exception.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/auth.provider.dart';
import 'package:shop/providers/cart.provider.dart';
import '../routes//routesPath.dart' as RoutesPath;

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen:false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              RoutesPath.PRODUCT_DETAIL,
              arguments: product,
            );
          },
        ),
        footer: GridTileBar(
          title: Text(
            product.name,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            builder: (contextConsumer, product, _) => IconButton(
              icon: Icon(product.isFavotire == true
                  ? Icons.favorite
                  : Icons.favorite_border_outlined),
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () async {
                try {
                  await product.toggleIsFavorite(auth.token ?? '', auth.userId ?? '');
                } on HttpException catch (error) {
                   ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(error.toString())
                    )
                  );
                }
              },
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () => {
              cart.addItem(product),
              ScaffoldMessenger.of(context).hideCurrentSnackBar(),
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text('Produto "${product.name}" adicionado com sucesso!'),
                duration: const Duration(seconds: 3),
                action: SnackBarAction(
                  label: 'DESFAZER',
                  onPressed: () {
                    cart.removeSingleItem(product.id);
                  },
                ),
              ))
            },
          ),
        ),
      ),
    );
  }
}
