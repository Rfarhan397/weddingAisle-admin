import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wedding_admin/model/res/constant/app_utils/utils.dart';
import 'package:wedding_admin/model/res/routes/routes_name.dart';
import 'package:wedding_admin/screens/vendors/vendor_detail_screen.dart';
import '../../constant.dart';
import '../../model/res/widgets/app_text.dart.dart';
import '../../providers/vendors/vendors_provider.dart';

class VendorsScreen extends StatefulWidget {
  @override
  _VendorsScreenState createState() => _VendorsScreenState();
}

class _VendorsScreenState extends State<VendorsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VendorsProvider>(context, listen: false).fetchVendors();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vendorProvider = Provider.of<VendorsProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: AppTextWidget(text: 'Vendors'),backgroundColor: primaryColor.withOpacity(0.2),),

      body: Column(
        children: [

          Expanded(
            child: vendorProvider.isLoading
                ? Center(child: CircularProgressIndicator(color: primaryColor,))
                : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: DataTable(
                        columnSpacing: 20.0,
                        headingRowColor: WidgetStateColor.resolveWith(
                                (states) => primaryColor.withOpacity(0.4)),
                        columns: [
                          DataColumn(label: AppTextWidget(text:"Name",  fontWeight: FontWeight.bold)),
                          DataColumn(label: AppTextWidget(text:"Email", fontWeight: FontWeight.bold)),
                          DataColumn(label: AppTextWidget(text:"Date", fontWeight: FontWeight.bold)),
                          DataColumn(label: AppTextWidget(text:"More", fontWeight: FontWeight.bold)),
                        ],
                        rows: vendorProvider.vendors
                            .map(
                              (vendor) => DataRow(
                            cells: [
                              DataCell(AppTextWidget(text:vendor.firstName ?? "N/A"),),
                              DataCell(AppTextWidget(text:vendor.email ?? "N/A")),
                              DataCell(AppTextWidget(text:AppUtils().formatTimestamp(vendor.createdAt.toString()) ?? "N/A")),
                              DataCell(
                                  onTap: () {
                                    context.push(
                                        RoutesName.vendorDetails,
                                      extra: vendor,
                                    );
                                  },
                                  Icon(Icons.info_outline,color: primaryColor,)),
                            ],
                          ),
                        )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
