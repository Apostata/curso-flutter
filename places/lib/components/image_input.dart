import 'dart:io';
import 'package:flutter/foundation.dart';
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

    final appDir = kIsWeb
        ? ''
        : await sysPaths
            .getApplicationDocumentsDirectory(); //pega diretório para armazenar a imagem
    String fileName = kIsWeb ? '' : path.basename(_storedImage!.path);
    final savedImage = kIsWeb
        ? _storedImage
        : await _storedImage!.copy('${(appDir as Directory).path}/$fileName');
    widget.onSelectImage(savedImage);
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
                ? kIsWeb
                    ? Image.network(
                        _storedImage!.path,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
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
