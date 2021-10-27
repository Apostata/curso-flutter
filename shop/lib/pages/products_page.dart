import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Components/AppDrawer.dart';
import 'package:shop/Components/AppbarCartActionButton.dart';
import 'package:shop/Components/Product_grid.dart';
import 'package:shop/providers/products.provider.dart';

enum FilterOptions { Favourites, All }

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  bool _showFavourites = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<Products>(context, listen: false).getProducts().then((_) {
      setState(() => {_isLoading = false});
    });
  }

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
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
                  _showFavourites = value == FilterOptions.Favourites;
                });
              }),
          const AppbarCartActionButton()
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductGrid(_showFavourites),
      drawer: const AppDrawer(),
    );
  }
}
