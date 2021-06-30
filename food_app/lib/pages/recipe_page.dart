import 'package:flutter/material.dart';
import 'package:food_app/models/recipes.dart';

class RecipeDetailPage extends StatelessWidget {
  final Function(Recipe) onToggleFavorite;
  final bool Function(Recipe) isFavorite;

  const RecipeDetailPage(this.onToggleFavorite, this.isFavorite);

  Widget _generateSectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _generateSectionContainer(context, child) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 200,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final recipe = ModalRoute.of(context)!.settings.arguments as Recipe;

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                recipe.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _generateSectionTitle(context, 'Ingredientes'),
            _generateSectionContainer(
              context,
              ListView.builder(
                itemCount: recipe.ingredients.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(recipe.ingredients[index]),
                    ),
                    color: Theme.of(context).accentColor,
                  );
                },
              ),
            ),
            _generateSectionTitle(context, 'Passos'),
            _generateSectionContainer(
                context,
                ListView.builder(
                  itemCount: recipe.steps.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text('${index + 1}'),
                            ),
                            title: Text(recipe.steps[index]),
                          ),
                        ),
                        Divider(),
                      ],
                    );
                  },
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(isFavorite(recipe) ? Icons.star : Icons.star_border),
          onPressed: () {
            onToggleFavorite(recipe);
          }),
    );
  }
}
