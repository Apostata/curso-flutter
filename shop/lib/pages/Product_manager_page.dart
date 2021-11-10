import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Components/AppDrawer.dart';
import 'package:shop/Components/Product_manager_item.dart';
import 'package:shop/providers/products.provider.dart';
import 'package:shop/routes/routesPath.dart' as RoutesPath;

class ProductManagerPage extends StatelessWidget {
  const ProductManagerPage({Key? key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context){
    return Provider.of<Products>(context, listen: false).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final Products products = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Produtos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed('${RoutesPath.PRODUCTS}/new');
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: ()=> _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 5,
          ),
          child: ListView.builder(
            itemCount: products.itemsCount,
            itemBuilder: (listCtx, i) => Column(
              children: [
                ProductManagerItem(product: products.products[i]),
                const Divider()
              ],
            ),
          ),
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}
