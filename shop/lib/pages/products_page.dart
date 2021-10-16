import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Components/Badge.dart';
import 'package:shop/Components/Product_grid.dart';
import 'package:shop/providers/cart.provider.dart';

enum FilterOptions { Favourites, All }

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  bool showFavourites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha loja'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
                  const PopupMenuItem(
                    child: Text('Only Favourites'),
                    value: FilterOptions.Favourites,
                  ),
                  const PopupMenuItem(
                    child: Text('All'),
                    value: FilterOptions.All,
                  )
                ],
            onSelected: (FilterOptions value) {
              setState(() {
                showFavourites = value == FilterOptions.Favourites;
              });
            }
          ),
          Consumer<Cart>(
            child: IconButton(
              onPressed: ()=>{}, 
              icon: const Icon(Icons.shopping_cart)
            ),
            builder:(ctxCart, cart, child) =>  Badge(
              child: child!, 
              value: cart.productsCount.toString(),
            ),
          )
        ],
      ),
      body: ProductGrid(showFavourites),
    );
  }
}
