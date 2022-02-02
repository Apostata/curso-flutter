class Contact {
  final String id;
  final String name;
  final int accountNumber;

  Contact({required this.id, required this.name, required this.accountNumber});

  Contact.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '', // no formulário não passa o id
        name = json['name'],
        accountNumber = json['accountNumber'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'accountNumber': accountNumber,
      };

  @override
  String toString() {
    return 'Contact{ name:$name, accountNumber:$accountNumber }';
  }
}
