import 'package:chat/models/chat_user.model.dart';
import 'package:chat/services/auth_firebase.service.dart';
// import 'package:chat/services/auth_mock.service.dart';

abstract class AuthService {
  ChatUser? get curretUser;
  Stream<ChatUser?> get userChanges;
  Future<void> signup(
    String name,
    String email,
    String password,
    dynamic image,
  );
  Future<void> login(
    String email,
    String password,
  );
  Future<void> logout();

  factory AuthService() {
    // return AuthServiceMock();
    return AuthServiceFirebase();
  }
}
