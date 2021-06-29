import 'package:flutter/material.dart';
import 'package:food_app/routes/routes.dart';
import '../models/recipes.dart';

class RecipeItem extends StatelessWidget {
  final Recipe recipe;

  const RecipeItem(this.recipe);

  void _selectRecipe(BuildContext context) {
    Navigator.of(context)
        .pushNamed(
          AppRoutes.RECIPE,
          arguments: recipe,
        )
        .then(
          (result) => {
            if (result == null)
              {
                print('no result'),
              }
            else
              {
                print((result as Recipe).title),
              }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectRecipe(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(25),
                  ),
                  child: Image.network(
                    recipe.imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      recipe.title,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.schedule),
                      SizedBox(
                        width: 6,
                      ),
                      Text('${recipe.duration} min')
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.work),
                      SizedBox(
                        width: 6,
                      ),
                      Text(recipe.complexityText)
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.attach_money),
                      SizedBox(
                        width: 6,
                      ),
                      Text(recipe.costText)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
