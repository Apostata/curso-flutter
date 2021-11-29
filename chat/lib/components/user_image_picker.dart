import 'dart:io';

import 'package:flutter/material.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File image) onImagePicked;
  const UserImagePicker({Key? key, required this.onImagePicked}) : super(key: key);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
        ),
      ],
    );
  }
}
