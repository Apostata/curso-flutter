import 'package:alura_bloc_intl/bloc/cubits/Name_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NamePage extends StatelessWidget {
  NamePage({Key? key}) : super(key: key);
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = context.read<NameCubit>().state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                label: Text('Desired Name:'),
              ),
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.read<NameCubit>().change(_nameController.text);
                  Navigator.pop(context);
                },
                child: const Text('change name'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
