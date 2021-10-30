import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Components/AppDrawer.dart';
import 'package:shop/Components/Order_widget.dart';
import 'package:shop/providers/orders.provider.dart';

class OrdersPageFuture extends StatelessWidget {
  const OrdersPageFuture({Key? key}) : super(key: key);

  Future<void> _refreshOrders(BuildContext context) {
    return Provider.of<Orders>(context, listen: false).getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
      ),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).getOrders(),
        builder: (ftureCtx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return const Center(child: Text('Ocorreu um erro'));
          } else {
            return RefreshIndicator(
              onRefresh: () => _refreshOrders(context),
              child: Consumer<Orders>(builder: (context, orders, _){
                if(orders.items.isEmpty) return const Center(child: Text('Nenhum pedido!'));
                return ListView.builder(
                  itemCount: orders.items.length,
                  itemBuilder: (builderContext, i) => OrderWidget(
                    order: orders.items[i],
                    key: ValueKey(orders.items[i].id),
                  ),
                );
              }),
            );
          }
        },
      ),
      drawer: const AppDrawer(),
    );
  }
}
