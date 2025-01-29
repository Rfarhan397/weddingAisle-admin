import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:wedding_admin/model/res/widgets/app_text.dart.dart';
import 'package:wedding_admin/model/res/widgets/button_widget.dart';
import 'package:wedding_admin/providers/action/action_provider.dart';
import '../../constant.dart';
import '../core/components/custom_dialog.dart';
import '../model/user/user_model.dart';
import '../providers/vendors/vendors_provider.dart';
import 'package:flutter_svg/svg.dart';

class VendorsListingRequestScreen extends StatefulWidget {
  const VendorsListingRequestScreen({super.key});

  @override
  State<VendorsListingRequestScreen> createState() =>
      _VendorsListingRequestScreenState();
}

class _VendorsListingRequestScreenState extends State<VendorsListingRequestScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VendorsProvider>(context, listen: false).fetchPendingSuppliers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vendorProvider = Provider.of<VendorsProvider>(context);
    final suppliers = vendorProvider.suppliers;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: AppTextWidget(text: "Vendors Listing Requests"),
        backgroundColor: primaryColor.withOpacity(0.2),
      ),
      body: vendorProvider.isLoading
          ? Center(child: CircularProgressIndicator(color: primaryColor))
          : Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 16),
            // Conditional rendering based on data availability
            if (suppliers.isEmpty)
              Center(
                child: Text(
                  "No pending vendor requests.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              )
            else
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 20,
                    mainAxisExtent: 35.h,
                    crossAxisSpacing: 20,
                  ),
                  shrinkWrap: true,
                  itemCount: suppliers.length,
                  itemBuilder: (context, index) {
                    final vendor = suppliers[index];

                    return VendorRequestCard(
                      vendorName: vendor.vendor.firstName!,
                      vendorCategory: vendor.category,
                      vendorImage: vendor.imageUrl,
                      vendorId: vendor.id.toString(),
                      listingStatus: vendor.listingStatus,
                      onAccept: () async {
                        await updateVendorStatus(vendor.id!, 'approved');
                        vendorProvider.fetchPendingSuppliers();
                      },
                      onReject: () {
                        _showRejectionDialog(context, vendor);
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
void _showRejectionDialog(BuildContext context, VendorListing vendor) {
  showDialog(
      context: context,
      builder: (context){
        return ConfirmationDialog(
          title: 'Update Status',
          message: 'Are you sure you want to Reject?',
          confirmText: 'Reject',
          onConfirm: () async{
            await updateVendorStatus(vendor.id!, 'rejected');
            Provider.of<VendorsProvider>(context, listen: false)
                .fetchPendingSuppliers();
            Navigator.pop(context);          },
        );
      }
  );
}
}

Future<void> updateVendorStatus(String supplierListingId, String newStatus) async {
  try {
    ActionProvider.startLoading();
    // Reference to the Firestore collection
    final CollectionReference vendorsCollection =
    FirebaseFirestore.instance.collection('supplierListing');

    // Update the status field for the specific vendor
    await vendorsCollection.doc(supplierListingId).update({
      'listingStatus': newStatus,
    });
    ActionProvider.stopLoading();
    print('Status updated to $newStatus for vendor $supplierListingId');
  } catch (e) {
    ActionProvider.stopLoading();
    print('Error updating status: $e');
  }
}
class VendorRequestCard extends StatelessWidget {
  const VendorRequestCard({
    super.key,
    required this.vendorName,
    required this.vendorCategory,
    required this.vendorImage,
    required this.vendorId,
    required this.listingStatus,
    required this.onAccept,
    required this.onReject,
  });

  final String vendorName;
  final String vendorCategory;
  final String vendorImage;
  final String vendorId;
  final String listingStatus;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First half: Image
          Container(
            height: 15.h, // Adjust the height as needed
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              image: DecorationImage(
                image: NetworkImage(vendorImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Second half: User data
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextWidget(
                  text: vendorName,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                AppTextWidget(
                  text: vendorCategory,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 1.h),
                AppTextWidget(
                  text: "Status: $listingStatus",
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: listingStatus == 'pending' ? Colors.red : primaryColor,
                ),
                SizedBox(height: 3.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonWidget(
                      text: "Decline",
                      width: 8.w,
                      height: 4.h,
                      backgroundColor: Colors.white,
                      onClicked: onReject,
                      fontWeight: FontWeight.w600,
                    ),
                    ButtonWidget(
                      text: "Accept",
                      width: 8.w,
                      height: 4.h,
                      onClicked: onAccept,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
