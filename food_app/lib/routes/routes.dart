import 'package:flutter/material.dart';
import 'package:food_app/pages/category.dart';

class AppRoutes {
  static const HOME = '/';
  static const CATEGORIES_FOOD = '/categories-food';
  static const RECIPE = '/recipe';
  static const SETTINGS = '/settings';
}

// final Map<String, WidgetBuilder> routes = {
//   // AppRoutes.HOME: (ctx) => CategoryPage(),
//   AppRoutes.HOME: (ctx) => TabsPage(),
//   AppRoutes.CATEGORIES_FOOD: (ctx) => CategoriesRecipesPage(),
//   AppRoutes.RECIPE: (ctx) => RecipeDetailPage(),
//   AppRoutes.SETTINGS: (ctx) => SettingPage(),
// };

// ignore: top_level_function_literal_block
final UnknownRoute = (settings) {
  return MaterialPageRoute(
    builder: (_) {
      return CategoryPage();
    },
  );
};
