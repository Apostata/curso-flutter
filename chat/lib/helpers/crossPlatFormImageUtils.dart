import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

const String fallbackImage = 'assets/images/avatar.png';

File Unit8ListToFile(Uint8List webFile) {
  return File.fromRawPath(webFile);
}

void pickWebOrFileImage(XFile xfileImage, Function callback) async {
  dynamic image;
  if (kIsWeb) {
    image = await xfileImage.readAsBytes();
  } else {
    image = File(xfileImage.path);
  }
  callback(image);
}

String imageToString(dynamic img) {
  String image = fallbackImage;
  if (img != null) {
    if (kIsWeb) {
      image = base64Encode(img);
    } else {
      image = (img as File).path;
    }
  }
  return image;
}

dynamic stringToImg(String imgStr) {
  dynamic image;
  final uri = Uri.parse(imgStr);
  if (uri.path.contains(fallbackImage)) {
    image = Image.asset((fallbackImage));
  } else if (kIsWeb) {
    image = Image.memory(base64Decode(imgStr));
  } else if (uri.scheme.contains('http')) {
    image = Image.network(uri.toString());
  } else {
    image = Image.file(File(uri.toString()));
  }
  return image;
}

ImageProvider stringToImageProvider(String img) {
  ImageProvider? imgProvider;
  final uri = Uri.parse(img);
  if (uri.path.contains(fallbackImage)) {
    imgProvider = const AssetImage(fallbackImage);
  } else if (uri.scheme.contains('http')) {
    imgProvider = NetworkImage(uri.toString());
  } else {
    imgProvider = FileImage(File(uri.toString()));
  }
  return imgProvider;
}

ImageProvider? getImageProvider(dynamic img, dynamic defaultImage) {
  ImageProvider? imageProvider;
  dynamic image = img;
  image = image ?? defaultImage;
  if (kIsWeb) {
    imageProvider = image != null ? MemoryImage(image) : null;
  } else {
    imageProvider = image != null ? FileImage(image) : null;
  }
  return imageProvider;
}
