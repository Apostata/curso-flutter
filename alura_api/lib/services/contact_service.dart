import 'package:alura_api/data/db_utils.dart';
import 'package:alura_api/models/contact_model.dart';
import 'package:uuid/uuid.dart';

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

  Future<int> saveContact(String name, int accountNumber) async {
    Uuid uuid = const Uuid();
    return db.insert(
      'contacts',
      {"id": uuid.v1(), "name": name, "accountNumber": accountNumber},
    );
  }
}
