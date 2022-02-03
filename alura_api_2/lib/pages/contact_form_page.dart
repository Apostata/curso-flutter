import 'package:alura_api_2/services/contact_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ContactFormPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();

  ContactFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contactService = ContactService();
    final contactId = Uuid().v4();

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                label: Text(
                  'Full name',
                ),
              ),
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: _accountController,
              decoration: const InputDecoration(
                label: Text(
                  'Account Number',
                ),
              ),
              style: const TextStyle(
                fontSize: 24,
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _nameController.text.isNotEmpty &&
                        int.tryParse(_nameController.text) != 0
                    ? () {
                        final String name = _nameController.text;
                        final int account =
                            int.tryParse(_accountController.text) ?? 0;
                        contactService
                            .saveContact(contactId, name, account)
                            .then((value) => Navigator.pop(context));
                      }
                    : null,
                child: const Text('Create'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
