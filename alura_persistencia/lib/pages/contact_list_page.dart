import 'package:flutter/material.dart';

import '../models/contact_model.dart';
import 'contact_form_page.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({Key? key}) : super(key: key);

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  List<Contact> contacts = [
    Contact(name: 'Alex', account: 1000),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (ctx, index) => Card(
          child: ListTile(
            title: Text(
              contacts[index].name,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            subtitle: Text(
              contacts[index].account.toString(),
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(
              MaterialPageRoute(builder: (context) => ContactFormPage()),
            )
            .then(
              (contact) => {
                setState(
                  () => contacts.add(contact),
                )
              },
            ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
