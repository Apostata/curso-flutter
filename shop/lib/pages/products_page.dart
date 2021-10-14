import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Components/Product_item.dart';
import 'package:shop/providers/products.provider.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Products>(context);
    final products = provider.products;

    return Scaffold(
      appBar: AppBar(title: const Text('Minha loja')),
      body: GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (ctx, i) => ProductItem(product: products[i])),
    );
  }
}
