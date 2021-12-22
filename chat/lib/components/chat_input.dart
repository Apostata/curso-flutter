import 'package:chat/models/auth_service.model.dart';
import 'package:chat/models/chat.service.model.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({Key? key}) : super(key: key);

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  String _message = '';
  final _messageController = TextEditingController();

  Future<void> _sendMessage() async {
    final user = AuthService().curretUser;
    if (user != null) {
      await ChatService().save(_message, user);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
        ),
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                onChanged: (msg) => setState(() => _message = msg),
                onSubmitted: (_) {
                  if (_message.trim().isNotEmpty) _sendMessage();
                },
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Enviar Mensagem...',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: _message.trim().isEmpty ? null : _sendMessage,
              icon: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
