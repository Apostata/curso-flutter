import 'package:flutter/material.dart';
import 'package:places/components/image_input.dart';

class PlaceFormPage extends StatefulWidget {
  const PlaceFormPage({Key? key}) : super(key: key);

  @override
  _PlaceFormPageState createState() => _PlaceFormPageState();
}

class _PlaceFormPageState extends State<PlaceFormPage> {
  final _titleControler = TextEditingController();

  void _submitForm(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Novo Lugar'),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _titleControler,
                        decoration: const InputDecoration(
                          labelText: 'Titulo',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const ImageInput()
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: _submitForm,
                style: ButtonStyle(
                  // backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0))),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Adicionar',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ))
          ],
        ));
  }
}
