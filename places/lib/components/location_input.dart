import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:places/helpers/location.utils.dart';
import 'package:places/pages/map_page.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPosition;
  const LocationInput(this.onSelectPosition, {Key? key}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageURL;

  void _showPreview(double? latitude, double? longitude) {
    final imageUrl = LocationUtil.generetaLocationPreview(
        latitude: latitude ?? 0, longitude: longitude ?? 0);
    setState(() {
      _previewImageURL = imageUrl;
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      final locationData = await Location().getLocation();
      // print('latitude:${locationData.latitude}, longitude: ${locationData.longitude}');
      _showPreview(locationData.latitude, locationData.longitude);
      widget.onSelectPosition(
          LatLng(locationData.latitude!, locationData.longitude!));
    } catch (e) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const MapPage()));
    if (selectedLocation == null) return;
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPosition(
        LatLng(selectedLocation.latitude, selectedLocation.longitude));
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
                onPressed: () => {_selectOnMap()},
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
