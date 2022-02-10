import 'package:alura_bloc_intl/data/db_utils.dart';
import 'package:alura_bloc_intl/models/contact_model.dart';

class ContactService {
  // singleton pattern

  // ContactService._constructor();
  // static final ContactService _instance = ContactService._constructor();

  // factory ContactService() {
  //   return _instance;
  // }

  static const DbUtil db = DbUtil(
    file: 'bytebank_api',
    table: 'contacts',
    scheema: [
      'id VARCHAR PRIMARY KEY',
      'name TEXT',
      'accountNumber INT',
    ],
    version: 1,
  );

  Future<List<Contact>> readContacts() async {
    final contactMaps = await db.getData('contacts');
    final List<Contact> contacts = contactMaps.isNotEmpty
        ? contactMaps
            .map(
              (map) => Contact.fromJson(map),
            )
            .toList()
        : [];
    return contacts;
  }

  Future<int> saveContact(String id, String name, int accountNumber) async {
    return db.insert(
      'contacts',
      {"id": id, "name": name, "accountNumber": accountNumber},
    );
  }
}
