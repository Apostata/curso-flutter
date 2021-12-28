import 'package:chat/helpers/crossPlatFormImageUtils.dart';
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
    return Stack(
      children: [
        Row(
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
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                margin: const EdgeInsets.fromLTRB(15, 20, 15, 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(12),
                      topRight: const Radius.circular(12),
                      bottomLeft: fromLoggedUser
                          ? const Radius.circular(0)
                          : const Radius.circular(12),
                      bottomRight: fromLoggedUser
                          ? const Radius.circular(12)
                          : const Radius.circular(0),
                    ),
                    color: fromLoggedUser
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondary),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: fromLoggedUser ? 20 : 0),
                              child: Text(
                                '${message.userName}:',
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: fromLoggedUser ? 0 : 20),
                              child: Text(
                                dateFormat.format(message.ceatedAt),
                                textAlign: fromLoggedUser
                                    ? TextAlign.right
                                    : TextAlign.left,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(message.text),
                  ],
                )),
          ],
        ),
        Positioned(
          top: 0,
          left: fromLoggedUser ? null : 165,
          right: fromLoggedUser ? 165 : null,
          child: CircleAvatar(
            backgroundImage: stringToImageProvider(message.imageUrl),
          ),
        ),
      ],
    );
  }
}
