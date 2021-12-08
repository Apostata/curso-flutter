import 'package:chat/models/chat_notification.dart';
import 'package:flutter/cupertino.dart';

class ChatNotificationService with ChangeNotifier {
  final List<ChatNotification> _notifications = [];

  List<ChatNotification> get notifications {
    return [..._notifications];
  }

  String get notificationsCount {
    final int length = _notifications.length;
    return length > 99 ? '+99' : length.toString();
  }

  void add(ChatNotification notification) {
    _notifications.add(notification);
    notifyListeners();
  }

  void remove(int index) {
    _notifications.removeAt(index);
    notifyListeners();
  }
}
