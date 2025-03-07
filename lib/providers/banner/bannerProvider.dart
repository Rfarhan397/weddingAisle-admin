import 'dart:developer';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../model/user/user_model.dart';
import '../action/action_provider.dart';
import '../cloudinary/cloudinary_provider.dart';

class BannerProvider extends ChangeNotifier {
  List<BannerModel> _banners = [];
  bool _isLoading = true;

  List<BannerModel> get banners => _banners;
  bool get isLoading => _isLoading;

  BannerProvider() {
    fetchBanners();
  }

  Future<void> fetchBanners() async {
    try {
      FirebaseFirestore.instance.collection('banner').snapshots().listen((snapshot) {
        _banners = snapshot.docs
            .map((doc) => BannerModel.fromMap(doc.data(), doc.id))
            .toList();
        _isLoading = false;
        notifyListeners();
      });

    } catch (e) {
      print("Error fetching banners: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  final TextEditingController descController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  Future<void> uploadBanner(BuildContext context) async {
    final cloudinaryProvider = Provider.of<CloudinaryProvider>(context, listen: false);

    try {
      // Validate fields
      ActionProvider.startLoading();
      if (descController.text.trim().isEmpty||titleController.text.trim().isEmpty ) {
        throw 'Please fill all fields';
      }

      // Validate image
      if (cloudinaryProvider.imageData == null) {
        throw 'Please select an image';
      }
      await cloudinaryProvider.uploadImage(cloudinaryProvider.imageData!);
      log('Image URL: ${cloudinaryProvider.imageUrl}');

      ActionProvider.stopLoading();
      // Save post data to Firestore
      final id =  FirebaseFirestore.instance.collection('banner').doc().id;
      await FirebaseFirestore.instance.collection('banner').doc(id).set({
        'title': titleController.text.trim(),
        'description': descController.text.trim(),
        'imageUrl': cloudinaryProvider.imageUrl.toString(),
        'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
        'id' : id
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('banner uploaded successfully!')),
      );

      // Clear fields and image
      descController.clear();
      notifyListeners();
    } catch (e) {
      // Improved error handling
      ActionProvider.stopLoading();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
      print('Error uploading banner: ${e.toString()}');
    }
  }

}
