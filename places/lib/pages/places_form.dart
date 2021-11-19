import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places/components/image_input.dart';
import 'package:places/components/location_input.dart';
import 'package:places/providers/Places.provider.dart';
import 'package:provider/provider.dart';

class PlaceFormPage extends StatefulWidget {
  const PlaceFormPage({Key? key}) : super(key: key);

  @override
  _PlaceFormPageState createState() => _PlaceFormPageState();
}

class _PlaceFormPageState extends State<PlaceFormPage> {
  final _titleControler = TextEditingController();
  File? _pickedImage;
  LatLng? _pickedPosition;

  bool _isValidForm() {
    return _titleControler.text.isNotEmpty || _pickedImage != null || _pickedPosition != null;
  }

  void _submitForm() {
    if (!_isValidForm()) return;
    Provider.of<Places>(context, listen: false)
        .addPlace(_titleControler.text, _pickedImage!, _pickedPosition!);
    Navigator.of(context).pop();
  }

  void _selectImage(File pickedImage) {
    setState(() {
    _pickedImage = pickedImage;
    });
  }

  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
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
                        // onChanged: (text) => setState(() {}),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ImageInput(_selectImage),
                      const SizedBox(
                        height: 10,
                      ),
                      LocationInput(_selectPosition)
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: _isValidForm() ? _submitForm : null,
                style: ButtonStyle(
                  // backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
