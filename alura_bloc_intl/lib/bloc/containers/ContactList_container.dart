import 'package:alura_bloc_intl/bloc/cubits/ContactList_cubit.dart';
import 'package:alura_bloc_intl/pages/contact_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactListContainer extends StatelessWidget {
  const ContactListContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactListCubit>(
      create: (contextBloc) {
        final cubit = ContactListCubit();
        cubit.reload();
        return cubit;
      },
      child: const ContactListPage(),
    );
  }
}
