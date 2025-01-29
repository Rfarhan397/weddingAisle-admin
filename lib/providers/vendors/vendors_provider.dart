import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../model/user/user_model.dart';

class VendorsProvider with ChangeNotifier {
  List<Vendor> _vendors = [];
  bool _isLoading = false;

  List<Vendor> get vendors => _vendors;
  bool get isLoading => _isLoading;

  Future<void> fetchVendors() async {
    _isLoading = true;
    notifyListeners();

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('vendors').get();
      _vendors = snapshot.docs.map((doc) => Vendor.fromMap(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      print("Error fetching users: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  List<VendorListing> _suppliers = [];
  List<VendorListing> get suppliers => _suppliers;

  Future<void> fetchPendingSuppliers() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('supplierListing')
          .where('listingStatus', isEqualTo: 'pending')
          .get();

      // Create a list to store the full vendor data
      List<VendorListing> vendorList = [];

      for (var doc in snapshot.docs) {
        // Get supplier data
        var supplierData = doc.data();

        // Fetch userUid to get the corresponding vendor
        String userUid = supplierData['userUid'];

        // Fetch the vendor details using userUid
        final vendorSnapshot = await FirebaseFirestore.instance
            .collection('vendors')
            .where('userId', isEqualTo: userUid)
            .get();

        if (vendorSnapshot.docs.isNotEmpty) {
          // Get vendor data from the snapshot
          var vendorData = vendorSnapshot.docs.first.data();

          // Create the Vendor object
          Vendor vendor = Vendor.fromMap(vendorData);

          // Combine both supplier and vendor info
          VendorListing vendorListing = VendorListing.fromMap(supplierData, vendor);

          // Add the combined vendorListing to the list
          vendorList.add(vendorListing);
        }
      }

      // Update the suppliers list with the combined data
      _suppliers = vendorList;
      notifyListeners();
    } catch (error) {
      print('Error fetching pending suppliers: $error');
    }
  }
}
