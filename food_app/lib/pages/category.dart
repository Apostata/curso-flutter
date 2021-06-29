import 'package:flutter/material.dart';
import 'package:food_app/components/category_item.dart';
import '../components/category_item.dart';
import '../data/dummy_data.dart' as data;

class CategoryPage extends StatelessWidget {
  final appBar = AppBar(
    title: Center(
      child: Text('Vamos cozinhar?'),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaquery = MediaQuery.of(context);
    //Sliver = area com scroll
    final double availableHight = mediaquery.size.height -
        appBar.preferredSize.height -
        mediaquery.padding.top;

    return GridView(
      padding: EdgeInsets.all(15),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisExtent: (availableHight / 5) - 25,
        childAspectRatio: 1 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: data.DUMMY_CATEGORIES.map((category) {
        return CategoryItem(category);
      }).toList(),
    );
  }
}
