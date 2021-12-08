import 'package:chat/services/chat_notification.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatNotificationService notificationProvider = Provider.of(context);
    final notifications = notificationProvider.notifications;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (ctx, i) => ListTile(
          title: Text(notifications[i].title),
          subtitle: Text(notifications[i].body),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              notificationProvider.remove(i);
            },
          ),
        ),
      ),
    );
  }
}
