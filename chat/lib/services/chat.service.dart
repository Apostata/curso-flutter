import 'package:chat/models/chat_message.dart';
import 'package:chat/models/chat_user.model.dart';
import 'package:chat/services/chat_mock.service.dart';

abstract class ChatService {
  Stream<List<ChatMessage>> messagesStream();
  Future<ChatMessage> save(String text, ChatUser user);

  factory ChatService() {
    return ChatServiceMock();
  }
}
