import 'package:flutter/material.dart';
import 'package:food_app/components/main_drawer.dart';
import 'package:food_app/models/recipes.dart';
import 'package:food_app/pages/category.dart';
import './favorite_page.dart';

class TabsPage extends StatefulWidget {
  final List<Recipe> favorites;
  const TabsPage(this.favorites);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _selectedIndex = 0;
  late List<Map<String, Object>> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      {
        'title': 'Lista de Categorias',
        'page': CategoryPage(),
      },
      {
        'title': 'Meus Favoritos',
        'page': FavoritePage(widget.favorites),
      },
    ];
  }

  _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectedIndex]['title'] as String),
        ),
        body: _pages[_selectedIndex]['page'] as Widget,
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.white,
          // ignore: deprecated_member_use
          selectedItemColor: Theme.of(context).accentColor,
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.shifting,
          onTap: _selectPage,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.category),
              label: 'Categorias',
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.star),
              label: 'Favoritos',
            )
          ],
        ),
        drawer: MainDrawer(),
      ),
    );
  }
}
