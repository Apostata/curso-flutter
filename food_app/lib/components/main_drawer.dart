import 'package:flutter/material.dart';
import '../routes/routes.dart' show AppRoutes;

class MainDrawer extends StatelessWidget {
  const MainDrawer();

  Widget _ceateItem(IconData icon, String label, void Function() onTap) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        label,
        style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            alignment: Alignment.bottomRight,
            height: 80,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).accentColor,
            child: Text(
              'Vamos cozinhar?',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _ceateItem(Icons.restaurant, 'Receitas',
              () => Navigator.of(context).pushReplacementNamed(AppRoutes.HOME)),
          _ceateItem(
              Icons.settings,
              'Configurações',
              () => Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.SETTINGS)),
        ],
      ),
    );
  }
}
