import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shop/errors/auth_exception.dart';
import 'package:shop/store/store.dart';

final ENV = dotenv.env;
const _singupAttribute = ':signUp';
const _loginttribute = ':signInWithPassword';

class Auth with ChangeNotifier {
  String? _token;
  String? _email;
  String? _userId;
  DateTime? _expirationDate;
  Timer? _logoutTimer;

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

      Store.saveMap('userData', {
        'token': _token,
        'email': _email,
        'userId': _userId,
        'expirationDate': _expirationDate!.toIso8601String()
      });

      _autoLogout();
      notifyListeners();
    } on DioError catch (e) {
      final response = (e.response);
      final message =
          response?.data['error']['message'] ?? 'Erro na authenticação!';
      throw AuthException(message);
    }
  }

  void logout() {
    
    Store.remove('userData').then((_){
    _email = null;
    _expirationDate = null;
    _token = null;
    _userId = null;
    _clearLogoutTimer();
    notifyListeners();
  });
    
  }

  void _clearLogoutTimer() {
    _logoutTimer?.cancel();
    _logoutTimer = null;
  }

  Future<void> tryAutoLogin() async {
    if (isAuth) {
      return;
    }
    final userData = await Store.getMap('userData');
    if (userData.isEmpty) {
      return;
    }

    final expirationDate = DateTime.parse(userData['expirationDate']);
    if (expirationDate.isBefore(DateTime.now())) {
      return;
    }

    _token = userData['token'];
    _email = userData['email'];
    _userId = userData['userId'];
    _expirationDate = expirationDate;

    _autoLogout();
    notifyListeners();
  }

  void _autoLogout() {
    _clearLogoutTimer();
    final timeToLogout = _expirationDate?.difference(DateTime.now()).inSeconds;
    _logoutTimer = Timer(Duration(seconds: timeToLogout ?? 0), logout);
  }
}
