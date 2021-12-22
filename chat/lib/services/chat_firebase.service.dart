import 'dart:async';
import 'package:chat/models/chat_message.dart';
import 'package:chat/models/chat_user.model.dart';
import 'package:chat/models/chat.service.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServiceFirebase implements ChatService {
  // static MultiStreamController<List<ChatMessage>>? _controller;
  // static final _msgStream = Stream<List<ChatMessage>>.multi((controller) {
  //   _controller = controller;
  //   controller.add(_msgs);
  // });

  @override
  Stream<List<ChatMessage>> messagesStream() {
    final store = FirebaseFirestore.instance;
    final snapshots = store
        .collection('chat')
        .orderBy('ceatedAt', descending: false)
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .snapshots();

    return Stream<List<ChatMessage>>.multi((controller) => {
          snapshots.listen((snapshot) {
            List<ChatMessage> list = snapshot.docs
                .map(
                  (doc) => doc.data(),
                )
                .toList();
            controller.add(list);
          })
        });
  }

  @override
  Future<ChatMessage?> save(String text, ChatUser user) async {
    final store = FirebaseFirestore.instance;

    final msg = ChatMessage(
      id: '',
      text: text,
      ceatedAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      imageUrl: user.urlImage,
    );

    final docRef = await store
        .collection('chat')
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .add(msg);

    final snapshot = await docRef.get();
    return snapshot.data()!;
  }

  ChatMessage _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    return ChatMessage(
      id: doc.id,
      text: doc['text'],
      ceatedAt: DateTime.parse(doc['ceatedAt']),
      userId: doc['userId'],
      userName: doc['userName'],
      imageUrl: doc['imageUrl'],
    );
  }

  Map<String, dynamic> _toFirestore(
    ChatMessage msg,
    SetOptions? options,
  ) {
    return {
      'text': msg.text,
      'ceatedAt': msg.ceatedAt.toIso8601String(),
      'userId': msg.userId,
      'userName': msg.userName,
      'imageUrl': msg.imageUrl,
    };
  }
}
