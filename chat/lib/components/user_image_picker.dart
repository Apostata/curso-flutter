import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final dynamic image;
  final void Function(dynamic image) onImagePicked;
  const UserImagePicker({Key? key, required this.onImagePicked, this.image})
      : super(key: key);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _image;
  Uint8List? _webImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (pickedImage != null) {
      if (kIsWeb) {
        Uint8List webImage = await pickedImage.readAsBytes();

        setState(() {
          _webImage = webImage;
        });
        widget.onImagePicked(_webImage!);
      } else {
        File image = File(pickedImage.path);
        setState(() {
          _image = image;
        });
        widget.onImagePicked(_image!);
      }
    }
  }

  dynamic _getDeviceImage() {
    if (kIsWeb) {
      return _webImage != null
          ? MemoryImage(_webImage!)
          : widget.image != null
              ? MemoryImage(widget.image)
              : null;
    }
    return _image != null
        ? FileImage(_image!)
        : widget.image != null
            ? FileImage(widget.image)
            : null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _getDeviceImage(),
        ),
        const SizedBox(height: 15),
        TextButton(
            onPressed: _pickImage,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.image),
                SizedBox(width: 15),
                Text('Adicionar imagem')
              ],
            ))
      ],
    );
  }
}
