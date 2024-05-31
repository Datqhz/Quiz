import 'dart:convert';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

Future<XFile?> pickImageFromGallery() async {
  XFile? image = await ImagePicker().pickImage(
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 100,
      source: ImageSource.gallery);
  return image;
}

Future<String> convertToBase64(XFile image) async{
  final bytes = await image.readAsBytes();
  String base64String = base64Encode(bytes);
  return base64String;
}

Uint8List convertBase64ToUint8List(String image) => base64Decode(image);
