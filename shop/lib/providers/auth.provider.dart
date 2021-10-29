import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shop/errors/auth_exception.dart';

final ENV = dotenv.env;
const _singupAttribute = ':signUp';
const _loginttribute = ':signInWithPassword';

class Auth with ChangeNotifier {
  String? _token;
  String? _email;
  String? _userId;
  DateTime? _expirationDate;

  bool get isAuth {
    final isValidDate = _expirationDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValidDate;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  String? get userId {
    return isAuth ? _userId : null;
  }

  Future<void> authenticate(formData, isSignUp) async {
    final authAttribute = isSignUp ? _singupAttribute : _loginttribute;
    try {
      final response = await Dio().post(
          '${ENV['API_SINGUP']}$authAttribute?key=${ENV['API_KEY']}',
          data: {
            'email': formData['email'],
            'password': formData['password'],
            'returnSecureToken': true
          });
      _token = response.data['idToken'];
      _userId = response.data['localId'];
      _email = response.data['email'];
      _expirationDate = DateTime.now()
          .add(Duration(seconds: int.parse(response.data['expiresIn'])));
      notifyListeners();
    } on DioError catch (e) {
      final response = (e.response) as Map<String, dynamic>;
      final message = response['error']['message'];
      throw AuthException(message);
    }
  }
}
