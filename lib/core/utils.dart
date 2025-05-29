import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackbar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  final imagePicker = ImagePicker();
  final imagesAsXFile = await imagePicker.pickMultiImage();
  if (imagesAsXFile.isNotEmpty) {
    for (final image in imagesAsXFile) {
      images.add(File(image.path));
    }
  }
  return images;
}
