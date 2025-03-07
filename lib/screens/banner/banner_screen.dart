import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wedding_admin/model/res/widgets/add_new_button.dart';

import '../../model/res/routes/routes_name.dart';
import '../../model/res/widgets/app_text.dart.dart';
import '../../providers/banner/bannerProvider.dart';

class BannerScreen extends StatelessWidget {
  const BannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AddNewButton(text: 'Add New Banner',onTap: () {
              context.push(
                RoutesName.addBanner,
                // extra: vendor,
              );
            },),
            SizedBox(height: 16.0),
            AppTextWidget(text: 'Banners', fontSize: 18),
            SizedBox(height: 16.0),
            Expanded(
              child: Consumer<BannerProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (provider.banners.isEmpty) {
                    return Center(child: Text('No Banners Available'));
                  }
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 16 / 9,
                    ),
                    itemCount: provider.banners.length,
                    itemBuilder: (context, index) {
                      final banner = provider.banners[index];
                      return InkWell(
                        onTap: () {
                          context.push(RoutesName.bannerDetails, extra: banner);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0),
                                  ),
                                  child: Image.network(
                                    banner.imageUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppTextWidget(
                                        text: banner.title ?? "Banner Title",
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      SizedBox(height: 4),
                                      AppTextWidget(
                                        text: banner.description ?? "No description available",
                                        fontSize: 10,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
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
}
