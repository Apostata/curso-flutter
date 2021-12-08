import 'dart:async';
import 'dart:math';

import 'package:chat/models/chat_message.dart';
import 'package:chat/models/chat_user.model.dart';
import 'package:chat/services/chat.service.dart';

class ChatServiceMock implements ChatService {
  static final List<ChatMessage> _msgs = [
    // ChatMessage(
    //   id: '1',
    //   text: 'Bem vindo! Rene.',
    //   ceatedAt: DateTime.now(),
    //   userId: '123',
    //   userName: 'Erica',
    //   imageUrl: 'assets/images/avatar.png',
    // ),
    // ChatMessage(
    //   id: '3',
    //   text: 'Prazer eu sou a Helena',
    //   ceatedAt: DateTime.now(),
    //   userId: '456',
    //   userName: 'Helena',
    //   imageUrl: 'assets/images/avatar.png',
    // ),
    // ChatMessage(
    //   id: '4',
    //   text: 'E eu a Diana!',
    //   ceatedAt: DateTime.now(),
    //   userId: '789',
    //   userName: 'Diana',
    //   imageUrl: 'assets/images/avatar.png',
    // ),
  ];
  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _msgStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    controller.add(_msgs);
  });

  @override
  Stream<List<ChatMessage>> messagesStream() {
    return _msgStream;
  }

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final _newMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      ceatedAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      imageUrl: user.urlImage,
    );
    _msgs.add(_newMessage);
    _controller?.add(_msgs);
    return _newMessage;
  }
}
