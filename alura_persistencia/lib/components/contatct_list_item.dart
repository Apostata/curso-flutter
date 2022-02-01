import 'package:alura_persistencia/models/contact_model.dart';
import 'package:flutter/material.dart';

class ContactListItem extends StatelessWidget {
  final Contact contact;
  const ContactListItem({
    Key? key,
    required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          contact.name,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        subtitle: Text(
          contact.account.toString(),
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
