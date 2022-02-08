import 'package:alura_state_management/components/dashboard_item.dart';
import 'package:alura_state_management/components/saldo_widget.dart';
import 'package:alura_state_management/pages/deposito_form_page.dart';
import 'package:alura_state_management/pages/transaction_list_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'contact_list_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  void toTransfer(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ContactListPage(),
      ),
    );
  }

  void toTransactionFeed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const TransactionListPage(),
      ),
    );
  }

  void toDeposit(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const DepositoFormPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                  '${!kIsWeb ? 'assets/' : ''}images/bytebank_logo.png'),
            ),
            const Center(
              child: SaldoWidget(),
            ),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  DashboardItem(
                    text: 'Transfer',
                    icon: Icons.monetization_on,
                    onTap: () => toTransfer(context),
                  ),
                  DashboardItem(
                    text: 'Transaction feed',
                    icon: Icons.description,
                    onTap: () => toTransactionFeed(context),
                  ),
                  DashboardItem(
                    text: 'Deposit',
                    icon: Icons.savings,
                    onTap: () => toDeposit(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
