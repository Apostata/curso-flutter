class ChatUser {
  final String id;
  String name;
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

  set Name(String nome) {
    name = nome;
  }

  // void setUrlImage(String image) {
  //   urlImage = image;
  // }
}
