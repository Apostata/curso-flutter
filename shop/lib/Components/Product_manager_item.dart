import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/providers/products.provider.dart';
import '../routes/routesPath.dart' as RoutesPath;

class ProductManagerItem extends StatelessWidget {
  final Product product;
  const ProductManagerItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          product.imageUrl,
        ),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                Navigator.of(context).pushNamed(
                    '${RoutesPath.PRODUCTS}/${product.id}',
                    arguments: {'id': product.id});
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () async{
                final deleteProduct = await showDialog<bool>(
                  context: context,
                  builder: (modalCtx) => AlertDialog(
                    title: const Text('Remover produto?'),
                    content: Text(
                        'Realmente deseja remover o produto "${product.name}"?'),
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
                            //ou chamar a exclusão dentro
                          }
                        ),
                    ],
                  ),
                );
                if(deleteProduct ?? false) {
                  Provider.of<Products>(context, listen: false).removeProduct(product.id);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
