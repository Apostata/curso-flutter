class Contact {
  final int id;
  final String name;
  final int account;

  Contact({this.id = 0, required this.name, required this.account});

  @override
  String toString() {
    return 'Contact{ name:$name, account:$account }';
  }
}
