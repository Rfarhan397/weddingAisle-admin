import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:wedding_admin/constant.dart';
import 'package:wedding_admin/model/res/constant/app_utils/utils.dart';
import 'package:wedding_admin/model/res/widgets/add_new_button.dart';
import 'package:wedding_admin/model/res/widgets/app_text_field.dart';
import 'package:wedding_admin/model/res/widgets/button_widget.dart';
import 'package:wedding_admin/providers/action/action_provider.dart';
import 'package:wedding_admin/providers/cloudinary/cloudinary_provider.dart';
import 'package:wedding_admin/providers/places/placesProvider.dart';

import '../../model/res/routes/routes_name.dart';
import '../../model/res/widgets/app_text.dart.dart';
import '../../providers/banner/bannerProvider.dart';

class AddPlacesScreen extends StatelessWidget {
  const AddPlacesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AddNewButton(
              text: 'Add New City',
              onTap: () {
                _showAddCityBottomSheet(context);
              },
            ),
            SizedBox(height: 16.0),
            AppTextWidget(text: 'Cities', fontSize: 18),
            SizedBox(height: 16.0),
            Expanded(
              child: Consumer<PlacesProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (provider.places.isEmpty) {
                    return Center(child: Text('No Cities Available'));
                  }
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 16 / 9,
                    ),
                    itemCount: provider.places.length,
                    itemBuilder: (context, index) {
                      final place = provider.places[index];
                      return Container(
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
                                  place.imageUrl,
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppTextWidget(
                                      text: place.city ?? "Banner Title",
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      textAlign: TextAlign.start,
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              _showAddCityBottomSheet(context, cityId: place.id, cityName: place.city, imageUrl: place.imageUrl);

                                            },
                                            child: Icon(Icons.edit,color: primaryColor,)),
                                        SizedBox(width: 1.w,),
                                        InkWell(
                                            onTap: () {
                                              FirebaseFirestore.instance.collection('cities').doc(place.id).delete();
                                            },
                                            child: Icon(Icons.delete,color: primaryColor,)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
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

  void _showAddCityBottomSheet(BuildContext context, {String? cityId, String? cityName, String? imageUrl}) {
    final cloud = Provider.of<CloudinaryProvider>(context, listen: false);
    TextEditingController cityController = TextEditingController(text: cityName);
    Uint8List? newImage;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            Future<void> _pickImage() async {
              await context.read<ActionProvider>().pickAndUploadImage(context);
              setState(() => newImage = cloud.imageData);
            }

            Future<void> _saveCity() async {
              if (cityController.text.trim().isEmpty) {
                AppUtils().showToast(text: 'Please enter a city name');
                return;
              }

              ActionProvider.startLoading();

              String finalImageUrl = imageUrl ?? "";

              // Upload only if a new image is picked
              if (newImage != null) {
                await cloud.uploadImage(newImage!);  // Wait for upload to complete
                finalImageUrl = cloud.imageUrl;      // Get the latest image URL
              }

              // Ensure finalImageUrl is not empty
              if (finalImageUrl.isEmpty) {
                AppUtils().showToast(text: 'Image upload failed. Please try again.');
                ActionProvider.stopLoading();
                return;
              }

              if (cityId != null) {
                await FirebaseFirestore.instance.collection('cities').doc(cityId).update({
                  'cityName': cityController.text.trim(),
                  'imageUrl': finalImageUrl,  // Update image URL
                  'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
                });
              } else {
                var id = FirebaseFirestore.instance.collection('cities').doc().id;
                await FirebaseFirestore.instance.collection('cities').doc(id).set({
                  'cityName': cityController.text.trim(),
                  'id': id,
                  'imageUrl': finalImageUrl,
                  'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
                });
              }

              ActionProvider.stopLoading();
              Navigator.pop(context);
            }

            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                top: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextWidget(
                    text: cityId == null ? 'Add New City' : 'Edit City',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 1.h),
                  AppTextField(
                    hintText: 'City Name',
                    controller: cityController,
                  ),
                  SizedBox(height: 2.h),

                  // Image Picker
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: newImage != null
                          ? Image.memory(newImage!, fit: BoxFit.cover)
                          : imageUrl != null
                          ? Image.network(imageUrl, fit: BoxFit.cover)
                          : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image, size: 50, color: Colors.grey),
                          Text("Tap to select an image"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),

                  ButtonWidget(
                    text: cityId == null ? 'Add City' : 'Update City',
                    onClicked: _saveCity,
                    width: 35.w,
                    height: 4.h,
                    fontWeight: FontWeight.w500,
                    radius: 5,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
