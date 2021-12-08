class ChatMessage {
  final String id;
  final String text;
  final DateTime ceatedAt;

  final String userId;
  final String userName;
  final dynamic imageUrl;

  ChatMessage({
    required this.id,
    required this.text,
    required this.ceatedAt,
    required this.userId,
    required this.userName,
    required this.imageUrl,
  });
}
