import 'dart:async';
import 'package:chat/models/auth_service.model.dart';
import 'package:chat/models/chat_message.dart';
import 'package:chat/models/chat_user.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class AuthServiceFirebase implements AuthService {
  static ChatUser? _currentUser; // mock de um usuário ativo
  static final _userStream = Stream<ChatUser?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();
    await for (final user in authChanges) {
      _currentUser = user == null ? null : _toChatUser(user);
      controller.add(_currentUser);
    }
  });

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
    final auth = FirebaseAuth.instance;
    UserCredential credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (credential.user == null) return;

    //upload imagem do usuário
    final imageName = '${credential.user!.uid}.jpg';
    final imageUrl = await _uploadUserImage(image, imageName);

    //atualizar atributos do usuário

    //atualizar atributos do usuário local
    _currentUser = _toChatUser(credential.user!, name, imageUrl);

    //atualizar atributos do usuário no firebase
    await credential.user?.updateDisplayName(name);
    await credential.user?.updatePhotoURL(imageUrl);

    // salva usuário no banco de dados
    await _saveChatUser(_toChatUser(credential.user!, name, imageUrl));
  }

  @override
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  Future<String?> _uploadUserImage(dynamic image, String imageName) async {
    if (image == null) return null;
    final storage = FirebaseStorage.instance;
    final imageRef = storage.ref().child('user_images').child(imageName);
    if (kIsWeb) {
      await imageRef.putData(image).whenComplete(() => {});
    } else {
      await imageRef.putFile(image!).whenComplete(() => {});
    }

    return await imageRef.getDownloadURL();
  }

  Future<void> _saveChatUser(ChatUser user) async {
    final store = FirebaseFirestore.instance;
    final docRef = store.collection('users').doc(user.id);
    docRef.set({
      'name': user.name,
      'email': user.email,
      'urlImage': user.urlImage,
    });
  }

  static ChatUser _toChatUser(User user, [String? name, String? imageUrl]) {
    return ChatUser(
      id: user.uid,
      name: name ?? user.displayName ?? user.email!.split('@')[0],
      email: user.email!,
      urlImage: imageUrl ?? user.photoURL ?? 'assets/images/avatar.png',
    );
  }
}
