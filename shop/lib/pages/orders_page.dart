import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Components/AppDrawer.dart';
import 'package:shop/Components/Order_widget.dart';
import 'package:shop/providers/orders.provider.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Orders orders = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
      ),
      body: ListView.builder(
        itemCount: orders.items.length,
        itemBuilder: (builderContext, i) => 
        OrderWidget(order:orders.items[i], key:ValueKey(orders.items[i].id),),
      ),
      drawer: const AppDrawer(),
    );
  } 
}
