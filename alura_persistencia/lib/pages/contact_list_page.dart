import 'package:alura_persistencia/components/contatct_list_item.dart';
import 'package:alura_persistencia/services/contact_service.dart';
import 'package:flutter/material.dart';
import '../models/contact_model.dart';
import 'contact_form_page.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({Key? key}) : super(key: key);

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  final contactService = ContactService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: const [],
        future: contactService.readContacts(),
        builder: (ctx, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none: //future não executado
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  children: const [
                    CircularProgressIndicator(),
                    Text('Loading...'),
                  ],
                ),
              );
            case ConnectionState
                .active: // tem dado disponível mas não terminou a execuçao, como uma Stream
              break;
            case ConnectionState.done:
              final contacts = snapshot.data;
              if (contacts == null || contacts.isEmpty) {
                return const Center(
                  child: Text('Nenhum Contato cadastrado'),
                );
              }
              return ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (ctx, index) => ContactListItem(
                  contact: contacts[index],
                ),
              );
          }
          return const Text('Unkonwn error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(
              MaterialPageRoute(builder: (context) => ContactFormPage()),
            )
            .then((value) => setState(() {})),
        child: const Icon(Icons.add),
      ),
    );
  }
}
