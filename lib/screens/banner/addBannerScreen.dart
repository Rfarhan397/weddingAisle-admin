import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:wedding_admin/constant.dart';
import 'package:wedding_admin/model/res/constant/app_utils/utils.dart';
import 'dart:html' as html;
import '../../model/res/widgets/app_text.dart.dart';
import '../../model/res/widgets/button_widget.dart';
import '../../model/res/widgets/textFieldWithTitle.dart';
import '../../providers/banner/bannerProvider.dart';
import '../../providers/cloudinary/cloudinary_provider.dart';

class AddBannerScreen extends StatelessWidget {
  const AddBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bannerProvider = Provider.of<BannerProvider>(context);
    final cloud = Provider.of<CloudinaryProvider>(context);

    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.all(customPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButton(),
           Row(
             children: [
               AppTextFieldWithTitle(
                 text: 'Title',
                 hintText: 'Enter a title',
                 controller: bannerProvider.titleController,
               ),
               SizedBox(width: 5.w,),
               AppTextFieldWithTitle(
                 text: 'Description',
                 hintText: 'Enter a description',
                 controller: bannerProvider.descController,
               ),
             ],
           ),
            SizedBox(height: 3.h,),
            InkWell(
              onTap: () {
                _pickAndUploadImage(context);
              },
              child: Container(
                height: 20.h,
                width: 30.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xffF7FAFC),
                  border: Border.all(color: const Color(0xffD1DBE8)),
                ),
                child: cloud.imageData != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    cloud.imageData!,
                    fit: BoxFit.cover,
                  ),
                )
                    : const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_outlined,
                        color: Color(0xff4F7396),
                        size: 32,
                      ),
                      SizedBox(height: 8),
                      AppTextWidget(
                        text: 'Upload Image',
                        textAlign: TextAlign.center,
                        color: Color(0xff4F7396),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 3.h),
            // Upload Button
            ButtonWidget(
              text: 'Upload',
              onClicked: () {
                bannerProvider.uploadBanner(context);
              },
              width: 25.w,
              radius: 15,
              height: 5.h,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _pickAndUploadImage(BuildContext context) async {
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