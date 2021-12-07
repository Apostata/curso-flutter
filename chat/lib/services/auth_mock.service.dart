import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:chat/models/auth_service.model.dart';
import 'package:chat/models/chat_user.model.dart';
import 'package:flutter/foundation.dart';

class AuthServiceMock implements AuthService {
  //exemplo de singleton
  static final _defaultUser = ChatUser(
      id: '481',
      name: 'Rene',
      email: 'admin@flutter.com',
      urlImage: '/assets/images/avatar.png');

  static final Map<String, ChatUser> _users = {
    _defaultUser.email: _defaultUser
  }; // mock de um banco
  static ChatUser? _currentUser; // mock de um usuário ativo
  static MultiStreamController<ChatUser?>? _controller;
  static final _userStream = Stream<ChatUser?>.multi((controller) {
    _controller = controller;
    _updateUser(_defaultUser);
  });

  static void _updateUser(ChatUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }

  @override
  ChatUser? get curretUser {
    return _currentUser;
  }

  @override
  Stream<ChatUser?> get userChanges {
    return _userStream;
  }

  @override
  Future<void> signup(
    String name,
    String email,
    String password,
    dynamic image,
  ) async {
    final File? file = kIsWeb
        ? image != null
            ? File.fromRawPath(image as Uint8List)
            : image
        : null;
    final user = ChatUser(
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
      urlImage: file?.path ?? '/assets/images/avatar.png',
    );
    _users.putIfAbsent(email, () => user);
    _updateUser(user);
  }

  @override
  Future<void> login(String email, String password) async {
    _updateUser(_users[email]);
  }

  @override
  Future<void> logout() async {
    _updateUser(null);
  }
}
