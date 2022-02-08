import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/Saldo_provider.dart';
import '../components/loadingButton.dart';

class DepositoFormPage extends StatefulWidget {
  const DepositoFormPage({Key? key}) : super(key: key);

  @override
  State<DepositoFormPage> createState() => _DepositoFormPageState();
}

class _DepositoFormPageState extends State<DepositoFormPage> {
  final _valueController = TextEditingController();
  final _accoutController = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receber Depósito'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.only(top: 16.0),
              //   child: TextField(
              //     controller: _accoutController,
              //     style: const TextStyle(fontSize: 24.0),
              //     decoration: const InputDecoration(labelText: 'Account'),
              //     keyboardType:
              //         const TextInputType.numberWithOptions(decimal: true),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: const TextStyle(fontSize: 24.0),
                  decoration: const InputDecoration(labelText: 'Value'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: LoadingButton(
                      loading: _loading,
                      text: _loading ? 'Sending' : 'Deposit',
                      onPress: () {
                        double valor =
                            double.tryParse(_valueController.text) ?? 0;
                        if (valor > 0) {
                          Provider.of<Saldo>(context, listen: false)
                              .addValue(valor);
                          Navigator.pop(context);
                        }
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
