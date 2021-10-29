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

  final _urlUserFavorites = '${dotenv.env['API_BASE']}/userFavorites';

  bool isFavotire;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavotire = false,
      });

  Future<void> toggleIsFavorite(String token, String userId) async {
    isFavotire = !isFavotire;
    notifyListeners();

    try{
      await Dio().put(
        '$_urlUserFavorites/$userId/$id.json?auth=$token', 
        data: isFavotire
      );
    } catch(error){
      isFavotire = !isFavotire;
      notifyListeners();
      throw HttpException(
        message: 'Não foi Possivel favoritar o produto $name!',
      );
    }
  }
}
