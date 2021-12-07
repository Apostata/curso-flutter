import 'package:chat/components/message_bubble.dart';
import 'package:chat/models/auth_service.model.dart';
import 'package:chat/models/chat_message.dart';
import 'package:chat/services/chat.service.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().curretUser;

    return StreamBuilder<List<ChatMessage>>(
      stream: ChatService().messagesStream(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('Nenhuma mensagem!',
                style: TextStyle(color: Colors.black)),
          );
        } else {
          final msgs = snapshot.data;
          return ListView.builder(
            itemCount: msgs?.length,
            itemBuilder: (lvCtx, i) => MessageBubble(
              message: msgs![i],
              fromLoggedUser: msgs[i].userId == currentUser!.id,
            ),
          );
        }
      },
    );
  }
}
