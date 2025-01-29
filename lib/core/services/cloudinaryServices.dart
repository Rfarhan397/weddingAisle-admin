
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:html' as html;

import 'package:provider/provider.dart';

import '../../providers/cloudinary/cloudinary_provider.dart';

class CloudinaryServices{


  CloudinaryServices._();
 static Future<void> pickAndUploadImage(BuildContext context) async {
   Uint8List? _imageData; 

   final html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*'; // Accept only images

    uploadInput.onChange.listen((e) async {
      final files = uploadInput.files;
      if (files!.isEmpty) return;

      final file = files[0];
      final fileSizeInBytes = file.size; // Get the file size in bytes
      final maxFileSizeInBytes = 5 * 1024 * 1024; // 5 MB in bytes

      if (fileSizeInBytes > maxFileSizeInBytes) {
        //AppUtils().showToast(text: 'Image size exceed to 5 MB');

        return;
      }

      final reader = html.FileReader();
      reader.readAsArrayBuffer(file);

      reader.onLoadEnd.listen((e) async {
        final bytes = reader.result as Uint8List;
        _imageData = bytes;

        // Set image data using Provider to display in the container
        final cloudinaryProvider = Provider.of<CloudinaryProvider>(context, listen: false);
        cloudinaryProvider.setImageData(bytes);

        //AppUtils().showToast(text: 'Image uploaded successfully');
      });
    });

    uploadInput.click(); // Trigger the file picker dialog
  }
}