import 'package:chat/models/chat_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final ENV = dotenv.env;

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

  Future<void> init() async {
    if (kIsWeb) {
      FirebaseMessaging.instance.getToken();
    }
    await _configureTerminated(); // terminado primeiro
    await _configureOpenedApp();
    await _configureForeground();
    await _configureBackground();
  }

  Future<bool> get _isAuthorized async {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission();
    // final token = await messaging.getToken(vapidKey: ENV['pushkey']!);
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<void> _configureOpenedApp() async {
    if (await _isAuthorized) {
      FirebaseMessaging.onMessageOpenedApp.listen(_messageHandler);
    }
  }

  Future<void> _configureForeground() async {
    if (await _isAuthorized) {
      FirebaseMessaging.onMessage.listen(_messageHandler);
    }
  }

  Future<void> _configureBackground() async {
    if (await _isAuthorized) {
      FirebaseMessaging.onBackgroundMessage(_futureMessageHandler);
    }
  }

  Future<void> _configureTerminated() async {
    if (await _isAuthorized) {
      RemoteMessage? initialMsg =
          await FirebaseMessaging.instance.getInitialMessage();
      _messageHandler(initialMsg);
    }
  }

  Future<void> _futureMessageHandler(RemoteMessage msg) async {
    return _messageHandler(msg);
  }

  void _messageHandler(RemoteMessage? msg) {
    if (msg == null || msg.notification == null) return;
    add(ChatNotification(
      title: msg.notification!.title ?? 'Não Informado',
      body: msg.notification!.body ?? 'Não Informado',
    ));
  }
}
