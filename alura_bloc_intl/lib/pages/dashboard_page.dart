import 'package:alura_bloc_intl/bloc/blocView.dart';
import 'package:alura_bloc_intl/bloc/containers/ContactList_container.dart';
import 'package:alura_bloc_intl/bloc/cubits/Name_cubit.dart';
import 'package:alura_bloc_intl/components/dashboard_item.dart';
import 'package:alura_bloc_intl/helpers/navigation.dart';
import 'package:alura_bloc_intl/models/Locale_model.dart';
import 'package:alura_bloc_intl/pages/name_page.dart';
import 'package:alura_bloc_intl/pages/transaction_list_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatelessWidget with BlocView {
  final DashboardI18nLazy i18n;
  DashboardPage({Key? key, required this.i18n}) : super(key: key);

  void toTransfer(BuildContext context) {
    push(
      context,
      const ContactListContainer(),
    );
  }

  void toTransactionFeed(BuildContext context) {
    push(
      context,
      const TransactionListPage(),
    );
  }

  void toChangeName(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (routeContext) => BlocProvider.value(
          value: BlocProvider.of<NameCubit>(context),
          child: NamePage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<NameCubit, String>(
          builder: (context, state) => Text('Welcome $state'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
                '${!kIsWeb ? 'assets/' : ''}images/bytebank_logo.png'),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  DashboardItem(
                    text: i18n.transfer,
                    icon: Icons.monetization_on,
                    onTap: () =>
                        navigateTo(context, const ContactListContainer()),
                  ),
                  DashboardItem(
                    text: i18n.transaction_feed,
                    icon: Icons.description,
                    onTap: () =>
                        navigateTo(context, const TransactionListPage()),
                  ),
                  DashboardItem(
                    text: i18n.change_name,
                    icon: Icons.person_outline,
                    onTap: () => toChangeName(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
