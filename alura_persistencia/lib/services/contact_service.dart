import 'package:alura_persistencia/data/db_utils.dart';
import 'package:alura_persistencia/models/contact_model.dart';

class ContactService {
  // singleton pattern

  // ContactService._constructor();
  // static final ContactService _instance = ContactService._constructor();

  // factory ContactService() {
  //   return _instance;
  // }

  static const DbUtil db = DbUtil(
    file: 'bytebank',
    table: 'contacts',
    scheema: [
      'id INTEGER PRIMARY KEY',
      'name TEXT',
      'account INT',
    ],
    version: 1,
  );

  Contact _mapToContact(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      name: map['name'],
      account: map['account'],
    );
  }

  Future<List<Contact>> readContacts() async {
    final contactMaps = await db.getData('contacts');
    final List<Contact> contacts = contactMaps.isNotEmpty
        ? contactMaps
            .map(
              (map) => _mapToContact(map),
            )
            .toList()
        : [];
    return contacts;
  }

  Future<int> saveContact(String name, int accpunt) async {
    return db.insert(
      'contacts',
      {"name": name, "account": accpunt},
    );
  }
}
