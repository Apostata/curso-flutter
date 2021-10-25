import 'package:flutter/material.dart';
import 'package:shop/Components/AppDrawer.dart';
import 'package:shop/Components/AppbarCartActionButton.dart';
import 'package:shop/Components/Product_grid.dart';

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
      backgroundColor: Theme.of(context).backgroundColor,
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
          const AppbarCartActionButton()
        ],
      ),
      body: ProductGrid(showFavourites),
      drawer: const AppDrawer(),
    );
  }
}
