import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wedding_admin/constant.dart';
import 'package:wedding_admin/model/res/widgets/app_text.dart.dart';
import '../../providers/user/user_provider.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: AppTextWidget(text: 'Users'),backgroundColor: primaryColor.withOpacity(0.2),),
      body: Column(
        children: [
          // Table Data
          Expanded(
            child: userProvider.isLoading
                ? Center(child: CircularProgressIndicator(color: primaryColor,))
                : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: DataTable(
                        columnSpacing: 20.0,
                        headingRowColor: WidgetStateColor.resolveWith(
                                (states) => primaryColor.withOpacity(0.4)),
                        columns: [
                          DataColumn(
                              label: AppTextWidget(text:
                                "Name",
                                fontWeight: FontWeight.bold),
                              ),
                          DataColumn(
                              label:AppTextWidget(text:
                              "Email",
                                fontWeight: FontWeight.bold),
                              ),
                          DataColumn(
                              label: AppTextWidget(text:
                              "Created At",
                                fontWeight: FontWeight.bold),
                              ),
                        ],
                        rows: userProvider.users
                            .map(
                              (user) => DataRow(
                            cells: [
                              DataCell(AppTextWidget(text: user.name ?? "N/A")),
                              DataCell(AppTextWidget(text: user.email ?? "N/A")),
                              DataCell(AppTextWidget(text: user.createdAt ?? "N/A")),
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
