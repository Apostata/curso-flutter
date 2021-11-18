import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places/models/place.model.dart';

class MapPage extends StatefulWidget {
  final Location initialLocation;
  final bool isReadOnly;

  const MapPage({
    Key? key,
    this.initialLocation =
        const Location(latitude: 37.4219838, longitude: -122.0840327),
        this.isReadOnly = false
  }) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  
   LatLng _selectedLocation = const LatLng(0, 0);

  void _selectMapLoLcation(LatLng location){
    setState(() {
      _selectedLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione!'),
        actions: 
          !widget.isReadOnly &&  _selectedLocation.latitude != 0 &&  _selectedLocation.longitude != 0? 
          [
            IconButton(
              onPressed: ()=>{
                Navigator.of(context).pop(_selectedLocation)
              },
              icon: const Icon(Icons.check)
            )
          ] :
          []
        ,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialLocation.latitude,
              widget.initialLocation.longitude),
          zoom: 13,
        ),
        onTap: widget.isReadOnly? null : _selectMapLoLcation,
        markers:{
          Marker(
            markerId: const MarkerId('pi'),
            position: _selectedLocation
          )
        },
      ),
    );
  }
}
