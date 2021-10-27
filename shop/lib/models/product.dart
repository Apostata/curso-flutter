import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shop/errors/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final _url = '${dotenv.env['API_BASE']}/products';

  bool isFavotire;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavotire = false});

  Future<void> toggleIsFavorite() async {
    isFavotire = !isFavotire;
    notifyListeners();

    try{
      await Dio().patch('$_url/$id.json', data: {'isFavorite': isFavotire});
    } catch(error){
      isFavotire = !isFavotire;
      notifyListeners();
      throw HttpException(
        message: 'Não foi Possivel favoritar o produto $name!',
      );
    }
  }
}
