import 'package:chat/helpers/crossPlatFormImageUtils.dart';
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
  dynamic _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (pickedImage != null) {
      pickWebOrFileImage(
        pickedImage,
        (image) => {
          setState(() {
            _image = image;
          }),
          widget.onImagePicked(image)
        },
      );
    }
  }

  // dynamic _getDeviceImage() {
  //   if (kIsWeb) {
  //     return _image != null
  //         ? MemoryImage(_webImage!)
  //         : widget.image != null
  //             ? MemoryImage(widget.image)
  //             : null;
  //   }
  //   return _image != null
  //       ? FileImage(_image!)
  //       : widget.image != null
  //           ? FileImage(widget.image)
  //           : null;
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: getImageProvider(_image, widget.image),
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
