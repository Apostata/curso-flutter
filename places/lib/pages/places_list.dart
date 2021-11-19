import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:places/providers/Places.provider.dart';
import 'package:places/routes/routes_path.dart';
import 'package:provider/provider.dart';

class PlacesListPage extends StatelessWidget {
  const PlacesListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final places = Provider.of<Places>(context).places;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lugares'),
        actions: [
          IconButton(
              onPressed: () =>
                  {Navigator.of(context).pushNamed(RoutesPath.PLACE_FORM)},
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Places>(context, listen: false).loadPlaces(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : Consumer<Places>(
                    child: const Center(
                      child: Text('Nenhum local Cadastrado'),
                    ),
                    builder: (ctx, places, child) => places.placesCount == 0
                        ? child!
                        : ListView.builder(
                            itemCount: places.placesCount,
                            itemBuilder: (ctx, i) {
                              final place =
                                  places.getPlace(places.places[i].id);
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: FileImage(place.image),
                                ),
                                title: Text(place.title),
                                subtitle: Text(place.location!.address ?? ''),
                                onTap: () => {
                                  Navigator.of(context).pushNamed(
                                    RoutesPath.PLACE_DETAIL,
                                    arguments: place,
                                  )
                                },
                              );
                            })
                          ),
        )
    );
  }
}
