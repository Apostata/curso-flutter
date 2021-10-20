import 'package:flutter/material.dart';
import '../routes/routesPath.dart' as RoutesPath;

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Bem vindo usuário'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Loja'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(RoutesPath.HOME);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Meus Pedidos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(RoutesPath.ORDERS);
            },
          )
        ],
      ),
    );
  }
}
