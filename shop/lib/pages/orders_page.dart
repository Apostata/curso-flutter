import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/Components/AppDrawer.dart';
import 'package:shop/Components/Order_widget.dart';
import 'package:shop/providers/orders.provider.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<Orders>(context, listen: false).getOrders().then((_){
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _refreshOrders(BuildContext context){
    return Provider.of<Orders>(context, listen: false).getOrders();
  }

  @override
  Widget build(BuildContext context) {
    final Orders orders = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
            onRefresh: ()=>_refreshOrders(context),
            child: ListView.builder(
                itemCount: orders.items.length,
                itemBuilder: (builderContext, i) => OrderWidget(
                  order: orders.items[i],
                  key: ValueKey(orders.items[i].id),
                ),
              ),
          ),
      drawer: const AppDrawer(),
    );
  }
}
