import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/pages/Auth_page.dart';
import 'package:shop/pages/products_page.dart';
import 'package:shop/providers/auth.provider.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    return auth.isAuth ? const ProductsPage() : const AuthPage();
  }
}
