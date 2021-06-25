import 'package:flutter/material.dart';
import 'package:food_app/models/category.dart';

class CategoriesFoodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as Category;
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: Center(
        child: Text('receitas por categoria:${category.id}'),
      ),
    );
  }
}
