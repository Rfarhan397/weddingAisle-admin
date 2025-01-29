import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../../model/user/user_model.dart';

class StreamDataProvider extends ChangeNotifier{
  final firestore = FirebaseFirestore.instance;

}