import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:chat/models/chat_message.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  static const String _assetsImage = 'assets/images/avatar.png';
  final ChatMessage message;
  final bool fromLoggedUser;
  const MessageBubble({
    Key? key,
    required this.message,
    required this.fromLoggedUser,
  }) : super(key: key);

  ImageProvider _showUserImage(dynamic imageUrl) {
    final teste = imageUrl is Uint8List;
    ImageProvider? imgProvider;
    final uri = Uri.parse(imageUrl);
    if (uri.path.contains(_assetsImage)) {
      imgProvider = const AssetImage(_assetsImage);
    } else if (kIsWeb) {
      print(imageUrl);
      final img = base64Decode(imageUrl);
      imgProvider = MemoryImage(img);
    } else if (uri.scheme.contains('http')) {
      imgProvider = NetworkImage(uri.toString());
    } else {
      imgProvider = FileImage(File(uri.toString()));
    }
    return imgProvider;
  }

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
                          Padding(
                            padding:
                                EdgeInsets.only(left: fromLoggedUser ? 20 : 0),
                            child: Text(
                              '${message.userName}:',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(right: fromLoggedUser ? 0 : 20),
                            child: Text(
                              dateFormat.format(message.ceatedAt),
                              textAlign: fromLoggedUser
                                  ? TextAlign.right
                                  : TextAlign.left,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
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
            backgroundImage: _showUserImage(message.imageUrl),
          ),
        ),
      ],
    );
  }
}
