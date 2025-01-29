import 'package:flutter/material.dart';
import '../../constant.dart';
import '../../model/res/widgets/app_text.dart.dart';
import '../../model/user/user_model.dart';

class VendorDetailsScreen extends StatelessWidget {
  final Vendor vendor;

  VendorDetailsScreen({required this.vendor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: AppTextWidget(text: "Vendor Details"),
        backgroundColor: primaryColor.withOpacity(0.2),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: DataTable(
                columnSpacing: 20.0,
                headingRowColor: WidgetStateColor.resolveWith(
                        (states) => primaryColor.withOpacity(0.4)),
                columns: [
                  DataColumn(
                      label: AppTextWidget(
                          text: "Field", fontWeight: FontWeight.bold)),
                  DataColumn(
                      label: AppTextWidget(
                          text: "Value", fontWeight: FontWeight.bold)),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(AppTextWidget(text: "Name")),
                    DataCell(AppTextWidget(text: vendor.firstName ?? "N/A")),
                  ]),
                  DataRow(cells: [
                    DataCell(AppTextWidget(text: "Email")),
                    DataCell(AppTextWidget(text: vendor.email ?? "N/A")),
                  ]),
                  DataRow(cells: [
                    DataCell(AppTextWidget(text: "Phone")),
                    DataCell(AppTextWidget(text: vendor.phoneNumber ?? "N/A")),
                  ]),
                  DataRow(cells: [
                    DataCell(AppTextWidget(text: "Company")),
                    DataCell(AppTextWidget(text: vendor.company ?? "N/A")),
                  ]),
                  DataRow(cells: [
                    DataCell(AppTextWidget(text: "Country")),
                    DataCell(AppTextWidget(text: vendor.country ?? "N/A")),
                  ]),
                  DataRow(cells: [
                    DataCell(AppTextWidget(text: "Status")),
                    DataCell(AppTextWidget(
                      text: vendor.status ?? "N/A",
                      color: vendor.status == 'approved' ? Colors.green : Colors.red,
                    )),
                  ]),
                  DataRow(cells: [
                    DataCell(AppTextWidget(text: "Created At")),
                    DataCell(AppTextWidget(text: vendor.createdAt ?? "N/A")),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}