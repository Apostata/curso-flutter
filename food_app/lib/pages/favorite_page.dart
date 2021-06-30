import 'package:flutter/material.dart';
import 'package:food_app/components/recipe_item.dart';
import 'package:food_app/models/recipes.dart';

class FavoritePage extends StatelessWidget {
  final List<Recipe> favorites;
  const FavoritePage(this.favorites);

  @override
  Widget build(BuildContext context) {
    if (favorites.isEmpty) {
      return Center(
        child: Text('nenhum favorito'),
      );
    } else {
      return ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, idx) {
          return RecipeItem(favorites[idx]);
        },
      );
    }
  }
}
