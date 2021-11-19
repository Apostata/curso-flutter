# Pefiféricos ( Camera, localização e etc...)

## Camera

### Plugin image_picker
no caso abaixo usando o plugin `image_picker`.

precisaremos de 3 pacotes instalados no `pubspec.yaml`:
`path`, `path_provider` e o `image_picker` 


```dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as sysPaths;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  const ImageInput(this.onSelectImage, {Key? key}) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  void _takePicture() async {
    final ImagePicker _picker = ImagePicker();

    XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (image == null) return;

    setState(() {
      _storedImage = File(image.path);
    });

    final appDir = await sysPaths
        .getApplicationDocumentsDirectory(); //pega diretório para armazenar a imagem
    String fileName = path.basename(_storedImage!.path);
    final savedImage = await _storedImage!.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage); //passa para o widget pai
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            height: 100,
            decoration:
                BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
            alignment: Alignment.center,
            child: _storedImage != null
                ? Image.file(
                    _storedImage!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : const Text('Nenhuma imagem...'),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: SizedBox(
            height: 100,
            child: TextButton(
              onPressed: _takePicture,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.camera,
                      // color: Colors.black,
                    ),
                  ),
                  Text(
                    'Tirar foto',
                    // style: TextStyle(color: Colors.black),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

```

## Location
Para usarmos o sistemade geoLocalização do aparelho teremos que adicionar alguns pacotes ao projeto no `pubspec.yaml`:
`location`' `google_maps_flutter` (utilizaremos o google maps) e `http` ou `dio`para requisições.

para isto teremos de criar uma conta e um projeto no google cloud, para que possamos habilitar os serviços de `static map` para pegar um preview da localização e o `geocode` para pegar uma cordenada e devolver o endereço, assim como o proprio aceso ao maps.
**NOTA: será necessário pegar a API-KEY do projeto** 

### criando o modelo de localização
```dart
import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location {
  final double latitude;
  final double longitude;
  final String? address;

  const Location({
    required this.latitude,
    required this.longitude,
    this.address,
  });

  LatLng locationToLatLng() {
    return LatLng(latitude, longitude);
  }
}

class Place {
 ...
  final Location? location;
  ...

  Place({
    ...
    required this.location,
    ...
  });
}
```

Um arquvi lera do SQLite os lugares salvos e mostrará num FutureBuilder. Não focaremos na descrição aqui mas cada item da lista irá chamar a págiga `map_page`, que terá a implementação do mapa, Para adicionar uma localização utilizaremos a página `places_form`:

(`map_page.dart`):
```dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  final LatLng initialLocation;
  final bool isReadOnly;

  const MapPage({
    Key? key,
    this.initialLocation =
        const LatLng( 37.4219838, -122.0840327), //localização inicial sede do google
        this.isReadOnly = false
  }) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  
   LatLng? _selectedLocation;

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
          !widget.isReadOnly &&  _selectedLocation != null? 
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
      body: GoogleMap( // aqui é renderizado o mapa do google
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialLocation.latitude,
              widget.initialLocation.longitude),
          zoom: 13,
        ),
        onTap: widget.isReadOnly? null : _selectMapLoLcation,
        markers:{
          Marker(
            markerId: const MarkerId('pi'),
            position: _selectedLocation ?? widget.initialLocation
          )
        },
      ),
    );
  }
}

```

(`places_form.dart`):
```dart
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
  ...
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

  ...

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
                      ...
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
```