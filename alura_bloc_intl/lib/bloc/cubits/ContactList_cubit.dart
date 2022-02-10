import 'package:alura_bloc_intl/models/contactListState.dart';
import 'package:alura_bloc_intl/models/contact_model.dart';
import 'package:alura_bloc_intl/pages/contact_list_page.dart';
import 'package:alura_bloc_intl/services/contact_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactListCubit extends Cubit<ContactsListState> {
  final contactService = ContactService();
  ContactListCubit() : super(InitContacsListState());

  void reload() async {
    emit(LoadingContactsListSate());
    List<Contact> contacts = await contactService.readContacts();
    if (contacts.isEmpty) {
      emit(EmptyContactListState());
    } else {
      emit(LoadedContactsListSate(contacts));
    }
  }
}
