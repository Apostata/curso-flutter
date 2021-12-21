class ChatUser {
  final String id;
  final String name;
  final String email;
  String urlImage;

  ChatUser({
    required this.id,
    required this.name,
    required this.email,
    required this.urlImage,
  });

  set UrlImage(String image) {
    urlImage = image;
  }

  // void setUrlImage(String image) {
  //   urlImage = image;
  // }
}
