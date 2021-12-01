import 'package:chat/models/auth_service.model.dart';
import 'package:chat/models/chat_user.model.dart';

class AuthServiceMock implements AuthService {
  @override
  ChatUser? get curretUser {
    return null;
  }

  @override
  Stream<ChatUser?> get userChanges {
    return {} as Stream<ChatUser>;
  }

  @override
  Future<void> signup(
      String name, String email, String password, dynamic image) async {}

  @override
  Future<void> login(String email, String password) async {}

  @override
  Future<void> logout() async {}
}
