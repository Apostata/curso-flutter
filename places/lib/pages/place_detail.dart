import 'package:flutter/material.dart';
import 'package:places/models/place.model.dart';
import 'package:places/pages/map_page.dart';

class PlaceDetail extends StatelessWidget {
  const PlaceDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Place place = ModalRoute.of(context)!.settings.arguments as Place;

    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Image.file(
                place.image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              place.location!.address ?? 'Sem endereço!',
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => MapPage(
                      initialLocation: place.location!.locationToLatLng(),
                      isReadOnly: true,
                    )
                  )
                );
              },
              icon: const Icon(Icons.map),
              label: const Text('Ver no mapa'),
              style: ButtonStyle(
                  textStyle: MaterialStateProperty.all(
                TextStyle(color: Theme.of(context).colorScheme.primary),
              )),
            )
          ],
        ),
      ),
    );
  }
}
