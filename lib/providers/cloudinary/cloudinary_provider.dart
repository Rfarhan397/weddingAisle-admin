import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CloudinaryProvider with ChangeNotifier {
  final String _cloudName = 'dmgyaqnss';
  final String _uploadPreset = 'articles'; // Changed from 'Article' to lowercase 'articles'

  String _imageUrl = '';
  Uint8List? _imageData;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String get imageUrl => _imageUrl;
  Uint8List? get imageData => _imageData;


  //to display image in container
  void setImageData(Uint8List data) {
    _imageData = data;
    notifyListeners();
  }

  // clear image
  void clearImage() {
    _imageData = null;
    notifyListeners();
  }

  Future<void> uploadImage(Uint8List imageBytes) async {
   //cloud name
    const String cloudName = 'dmgyaqnss';
    //folder name
    const String uploadPreset = 'articles'; // Changed here too
    const String folderName = 'images'; // Specify the folder
// signed preset

    final uri = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
    final request = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] = uploadPreset
      ..fields['folder'] = folderName // Add the folder parameter
      ..files.add(http.MultipartFile.fromBytes('file', imageBytes, filename: 'image.jpg'));

    try {
      final response = await request.send();
      log("Status Code:: ${response.statusCode}");
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseBody);
        _imageUrl = jsonResponse['secure_url'];
        log("Image Url:: ${jsonResponse['secure_url']}");

        notifyListeners(); // Notify listeners about the change
      } else {
        final responseBody = await response.stream.bytesToString();
        log("Response Body:: ${responseBody}");
        throw Exception('Failed to upload image: $responseBody');
      }
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }}