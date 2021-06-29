import 'package:flutter/material.dart';
import 'package:food_app/models/settings.dart';
import 'package:food_app/pages/categories_recipeList_page.dart';
import 'package:food_app/pages/recipe_page.dart';
import 'package:food_app/pages/settings_page.dart';
import 'package:food_app/pages/tabs_page.dart';
import './routes/routes.dart' show AppRoutes, UnknownRoute;
import './Theme/theme.dart';
import './models/recipes.dart';
import './data/dummy_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Recipe> _availablesRecipes = DUMMY_MEALS;
  Settings settings = Settings();

  void _filterRecipes(Settings settings) {
    setState(() {
      this.settings = settings;
      _availablesRecipes = DUMMY_MEALS.where((recipe) {
        final isFilteredByGluten =
            settings.isGlutenFree && !recipe.isGlutenFree;
        final isFilteredByLactose =
            settings.isLactoseFree && !recipe.isLactoseFree;
        final isFilteredByVegan = settings.isVegan && !recipe.isVegan;
        final isFilteredByVegetarian =
            settings.isVegetarian && !recipe.isVegetarian;
        return !isFilteredByGluten &&
            !isFilteredByLactose &&
            !isFilteredByVegan &&
            !isFilteredByVegetarian;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FodApp',
      theme: theme,
      routes: {
        AppRoutes.HOME: (ctx) => TabsPage(),
        AppRoutes.CATEGORIES_FOOD: (ctx) =>
            CategoriesRecipesPage(_availablesRecipes),
        AppRoutes.RECIPE: (ctx) => RecipeDetailPage(),
        AppRoutes.SETTINGS: (ctx) => SettingPage(settings, _filterRecipes),
      },
      onGenerateRoute: (settins) {
        if (settins.name == '/alguma-coisa') {
          return null;
        } else if (settins.name == '/outra-coisa') {
          return null;
        } else {
          return MaterialPageRoute(
            builder: (_) {
              return TabsPage();
            },
          );
        }
      },
      onUnknownRoute: UnknownRoute,
    );
  }
}
