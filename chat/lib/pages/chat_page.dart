import 'package:chat/components/chat_input.dart';
import 'package:chat/components/chat_messages.dart';
import 'package:chat/models/auth_service.model.dart';
import 'package:chat/pages/notiffication_page.dart';
import 'package:chat/services/chat_notification.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Row(
                    children: const [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.black87,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Sair')
                    ],
                  ),
                )
              ],
              onChanged: (value) {
                if (value == 'logout') {
                  AuthService().logout();
                }
              },
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) {
                      return const NotificationPage();
                    }),
                  );
                },
                icon: const Icon(Icons.notifications),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  maxRadius: 10,
                  backgroundColor: Colors.red.shade800,
                  child: Text(
                    Provider.of<ChatNotificationService>(context)
                        .notificationsCount,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: const [
            Expanded(
              child: ChatMessages(),
            ),
            ChatInput()
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () {
      //     Provider.of<ChatNotificationService>(context, listen: false).add(
      //       ChatNotification(
      //         title: 'title ${Random().nextDouble()}',
      //         body: 'body ${Random().nextDouble()}',
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
