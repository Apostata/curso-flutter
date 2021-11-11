import 'package:flutter/material.dart';
import 'package:places/routes/routes_path.dart';

class PlacesListPage extends StatelessWidget {
  const PlacesListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lugares'),
        actions: [
          IconButton(
            onPressed: () => {
              Navigator.of(context).pushNamed(RoutesPath.PLACE_FORM)
            },
            icon: const Icon(Icons.add)
          )
        ],
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
