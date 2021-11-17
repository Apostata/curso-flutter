import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:places/helpers/location.utils.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageURL;

  Future<void> _getCurrentLocation() async {
    final locationData = await Location().getLocation();
    // print('latitude:${locationData.latitude}, longitude: ${locationData.longitude}');
    final imageUrl = LocationUtil.generetaLocationPreview(
        latitude: locationData.latitude ?? 0,
        longitude: locationData.longitude ?? 0);
    setState(() {
      _previewImageURL = imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 170,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.green)),
            child: _previewImageURL == null
                ? const Text('Localização não informada!')
                : Image.network(
                    _previewImageURL!,
                    fit: BoxFit.contain,
                    width: double.infinity,
                  )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
                onPressed: () => {_getCurrentLocation()},
                icon: const Icon(Icons.location_on),
                label: const Text('Localização'),
                style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(
                  TextStyle(color: Theme.of(context).colorScheme.primary),
                ))),
            TextButton.icon(
                onPressed: () => {},
                icon: const Icon(Icons.map),
                label: const Text('Selecione no Mapa'),
                style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(
                  TextStyle(color: Theme.of(context).colorScheme.primary),
                ))),
          ],
        )
      ],
    );
  }
}
