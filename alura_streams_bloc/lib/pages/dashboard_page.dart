import 'package:alura_streams_bloc/bloc/blocView.dart';
import 'package:alura_streams_bloc/components/dashboard_item.dart';
import 'package:alura_streams_bloc/helpers/navigation.dart';
import 'package:alura_streams_bloc/pages/name_page.dart';
import 'package:alura_streams_bloc/pages/transaction_list_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/containers.dart';
import '../bloc/cubits.dart';

class DashboardPage extends StatelessWidget with BlocView {
  DashboardPage({Key? key}) : super(key: key);

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
                    text: 'Transfer',
                    icon: Icons.monetization_on,
                    onTap: () =>
                        navigateTo(context, const ContactListContainer()),
                  ),
                  DashboardItem(
                    text: 'Transaction feed',
                    icon: Icons.description,
                    onTap: () =>
                        navigateTo(context, const TransactionListPage()),
                  ),
                  DashboardItem(
                    text: 'Change Name',
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
