
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/res/constant/app_utils/utils.dart';
import 'dart:html' as html;

import '../cloudinary/cloudinary_provider.dart';


class ActionProvider extends ChangeNotifier{
  int _selectedIndex = 0;
  final Map<int, bool> _isHovered = {};
  final Map<int, bool> _isLoading = {};

  Map<int, bool> _isCardHovered = {};

  bool isCardHovered(int index) => _isCardHovered[index] ?? false;

  void setHover(int index, bool value) {
    _isCardHovered[index] = value;
    notifyListeners();
  }

  static final ActionProvider _instance = ActionProvider._internal();
  factory ActionProvider() => _instance;
  ActionProvider._internal();

  int get selectedIndex => _selectedIndex;
  bool  isHovered(int index) => _isHovered[index] ?? false;
  bool  isLoading(int index) => _isLoading[index] ?? false;

  void selectMenu(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void onHover(int index,bool isHovered) {
    _isHovered[index] = isHovered;
    notifyListeners();
  }

  void setLoading(bool isLoading) {
    _isLoading[0] = isLoading;
    notifyListeners();
  }

  // Static methods to start and stop loading globally
  static void startLoading() {
    _instance.setLoading(true);
  }

  static void stopLoading() {
    _instance.setLoading(false);
  }


  final Map<String, bool> _loadingStates = {};
  bool isLoadingState(String key) => _loadingStates[key] ?? false;

  void setLoadingState(String key, bool loading) {
    _loadingStates[key] = loading;
    notifyListeners();
  }
  
  bool _isFooterHovered = false;

  bool get isFooterHovered => _isFooterHovered;

  void setHovered(bool value) {
    _isFooterHovered = value;
    notifyListeners();
  }

  int _hoveredIndex = -1;

  int get hoveredIndex => _hoveredIndex;

  void setHoveredIndex(int index) {
    _hoveredIndex = index;
    notifyListeners();
  }

  void clearHover() {
    _hoveredIndex = -1;
    notifyListeners();
  }


  bool _isEditVisible = false;
  bool get isEditVisible => _isEditVisible;

  void setEditVisible(bool value) {
    _isEditVisible = value;
    notifyListeners();
  }


  final GlobalKey<ScaffoldState> _scaffoldKeyDashboard = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKeyDashboard;

  void controlMenuDashboard() {
    if (!_scaffoldKeyDashboard.currentState!.isDrawerOpen) {
      _scaffoldKeyDashboard.currentState!.openDrawer();
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKeyInstructor = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKeyInstructor => _scaffoldKeyInstructor;

  void controlMenuInstructor() {
    if (!_scaffoldKeyInstructor.currentState!.isDrawerOpen) {
      _scaffoldKeyInstructor.currentState!.openDrawer();
    }
  }


  // date picker d
  DateTime? _selectedDateTime;

  DateTime? get selectedDateTime => _selectedDateTime;

  void setDateTime(DateTime dateTime) {
    _selectedDateTime = dateTime;
    notifyListeners();
  }

  DateTimeRange? _selectedDateTimeRange;

  DateTimeRange? get selectedDateTimeRange => _selectedDateTimeRange;

  void setDateTimeRange(DateTimeRange dateTimeRange) {
    _selectedDateTimeRange = dateTimeRange;
    notifyListeners();
  }



  Future<void> pickAndUploadImage(BuildContext context) async {
    final html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*'; // Accept only images

    uploadInput.onChange.listen((e) async {
      final files = uploadInput.files;
      if (files!.isEmpty) return;

      final reader = html.FileReader();
      reader.readAsArrayBuffer(files[0]);

      reader.onLoadEnd.listen((e) async {
        final bytes = reader.result as Uint8List;

        // Set image data using Provider to display in the container
        final cloudinaryProvider = Provider.of<CloudinaryProvider>(context, listen: false);
        cloudinaryProvider.setImageData(bytes);

        AppUtils().showToast(text: 'Image uploaded successfully');
      });
    });

    uploadInput.click(); // Trigger the file picker dialog
  }


}