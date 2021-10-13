import 'package:flutter/material.dart';
import 'package:shop/Components/Product_item.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductsPage extends StatelessWidget {
  ProductsPage({Key? key}) : super(key: key);
  final List<Product> products = dummyProducts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minha loja')),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3/2,
              crossAxisSpacing: 10, 
              mainAxisSpacing: 10,
            ),
          itemBuilder: (ctx, i) => ProductItem(product: products[i])),
    );
  }
}
