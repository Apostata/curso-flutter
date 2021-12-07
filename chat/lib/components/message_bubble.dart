import 'package:chat/models/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool fromLoggedUser;
  const MessageBubble({
    Key? key,
    required this.message,
    required this.fromLoggedUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yy hh:mm');
    return Row(
      mainAxisAlignment:
          fromLoggedUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
            constraints: BoxConstraints.loose(
              const Size(
                180,
                double.infinity,
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
                color: fromLoggedUser
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.secondary),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${message.userName}:',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        dateFormat.format(message.ceatedAt),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      )
                    ],
                  ),
                ),
                Text(message.text),
              ],
            )),
      ],
    );
  }
}
