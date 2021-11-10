import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shop/providers/auth.provider.dart';
import 'package:shop/providers/orders.provider.dart';
import 'package:shop/providers/products.provider.dart';
import 'package:shop/providers/cart.provider.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => Auth()),
  ChangeNotifierProxyProvider<Auth, Products>(
    create: (_) => Products(),
    update: (ctx, auth, previous) {
      return Products(auth.token ?? '', auth.userId ?? '', previous?.products ?? []);
    },
  ),
  ChangeNotifierProxyProvider<Auth, Orders>(
    create: (_) => Orders(),
    update: (ctx, auth, previous){
      return Orders(auth.token ?? '', auth.userId ?? '', previous?.items ?? []);
    },
  ),
  ChangeNotifierProvider(create: (_) => Cart()),
];
