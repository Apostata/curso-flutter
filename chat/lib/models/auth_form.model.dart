import 'package:chat/helpers/FormData.dart';

enum AuthMode { Singup, Login }

class AuthFormData implements FormData{
  String name = '';
  String email = '';
  String password = '';
  dynamic image;
  AuthMode _mode = AuthMode.Login;

  bool get isLogin {
    return _mode == AuthMode.Login;
  }

  bool get isSignup {
    return _mode == AuthMode.Singup;
  }

  @override
  dynamic getKey(key) {
    return {'name': name, 'email': email, 'password': password, 'image': image}[key];
  }

  void toggleAuthMode() {
    _mode = isLogin ? AuthMode.Singup : AuthMode.Login;
  }
}
