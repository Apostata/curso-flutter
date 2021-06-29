import 'package:flutter/material.dart';
import 'package:food_app/models/recipes.dart';
import '../models/category.dart';
import '../components/recipe_item.dart';
import '../data/dummy_data.dart';

class CategoriesRecipesPage extends StatelessWidget {
  final List<Recipe> availablesRecipes;
  CategoriesRecipesPage(this.availablesRecipes);

  @override
  Widget build(BuildContext context) {
    final routeArg = ModalRoute.of(context);
    print(routeArg);
    final category = routeArg!.settings.arguments as Category;
    final availablesRecipes = DUMMY_MEALS;
    final recipes = availablesRecipes.where((recipe) {
      return recipe.categories.contains(category.id);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (ctx, index) {
          return RecipeItem(recipes[index]);
          // return Text(recipes[index].title);
        },
      ),
    );
  }
}
