import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/Saldo_provider.dart';

class SaldoWidget extends StatelessWidget {
  const SaldoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Saldo>(
      builder: (consumerContext, saldoProvider, chidl) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  saldoProvider.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
          // FloatingActionButton(
          //   onPressed: () {
          //     saldoProvider.addValue(10);
          //   },
          //   child: const Icon(Icons.add),
          //   backgroundColor: Theme.of(context).colorScheme.primary,
          // )
        ],
      ),
    );
  }
}
