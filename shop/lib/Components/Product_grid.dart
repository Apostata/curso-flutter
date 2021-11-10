import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products.provider.dart';
import 'package:shop/Components/Product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavourites;
  const ProductGrid(this.showFavourites, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Products>(context);
    final products =
        showFavourites ? provider.favouriteProducts :  provider.products;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            //passa produto via provider
            value: products[i],
            child: ProductItem(
              key:ValueKey(products[i].id
            )
          ), //sempre que uma lista de um statefull widget for alterado, use key para manter a referência
      )
    );
  }
}
