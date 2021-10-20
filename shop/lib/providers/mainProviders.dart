import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shop/providers/orders.provider.dart';
import 'package:shop/providers/products.provider.dart';
import 'cart.provider.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => Products()),
  ChangeNotifierProvider(create: (_) => Cart()),
  ChangeNotifierProvider(create: (_) => Orders()),
];
