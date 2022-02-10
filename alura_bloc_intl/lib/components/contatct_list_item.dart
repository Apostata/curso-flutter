import 'package:alura_bloc_intl/models/contact_model.dart';
import 'package:flutter/material.dart';

class ContactListItem extends StatelessWidget {
  final Contact contact;
  final Function() onTap;

  const ContactListItem({Key? key, required this.contact, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(
          contact.name,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
