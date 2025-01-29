import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class MenuAppController extends ChangeNotifier {

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void changeScreen(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

}
