import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../model/user/user_model.dart';

class PlacesProvider extends ChangeNotifier{
  List<PlaceModel> _places = [];
  bool _isLoading = true;

  List<PlaceModel> get places => _places;
  bool get isLoading => _isLoading;

  PlacesProvider() {
    fetchCities();
  }

  Future<void> fetchCities() async {
    try {
      FirebaseFirestore.instance.collection('cities').snapshots().listen((snapshot) {
        _places = snapshot.docs
            .map((doc) => PlaceModel.fromMap(doc.data()))
            .toList();
        _isLoading = false;
        notifyListeners();
      });

    } catch (e) {
      print("Error fetching cities: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}