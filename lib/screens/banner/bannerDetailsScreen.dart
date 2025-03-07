import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wedding_admin/constant.dart';
import 'package:wedding_admin/model/res/widgets/app_text.dart.dart';
import 'package:wedding_admin/model/res/widgets/button_widget.dart';
import 'package:wedding_admin/model/res/widgets/textFieldWithTitle.dart';
import 'package:wedding_admin/providers/action/action_provider.dart';
import 'package:wedding_admin/providers/banner/bannerProvider.dart';
import '../../model/user/user_model.dart';
import '../../providers/cloudinary/cloudinary_provider.dart';

class BannerDetailsScreen extends StatefulWidget {
  final BannerModel banner;
  const BannerDetailsScreen({Key? key, required this.banner}) : super(key: key);

  @override
  _BannerDetailsScreenState createState() => _BannerDetailsScreenState();
}

class _BannerDetailsScreenState extends State<BannerDetailsScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.banner.title;
    _descriptionController.text = widget.banner.description;
  }



  void _deleteBanner() async {
    await FirebaseFirestore.instance.collection('banner').doc(widget.banner.id).delete();
    Navigator.pop(context);
  }

  void _showEditDialog() {
    TextEditingController titleController = TextEditingController(text: widget.banner.title);
    TextEditingController descriptionController = TextEditingController(text: widget.banner.description);
    ValueNotifier<Uint8List?> imageNotifier = ValueNotifier<Uint8List?>(null);

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
            width: 400,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Edit Banner', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    AppTextFieldWithTitle(text: 'Title', hintText: 'Enter title', controller: titleController),
                    SizedBox(height: 10),
                    AppTextFieldWithTitle(text: 'Description', hintText: 'Enter description', controller: descriptionController),
                    SizedBox(height: 10),

                    // Image Preview
                    ValueListenableBuilder<Uint8List?>(
                      valueListenable: imageNotifier,
                      builder: (context, imageData, child) {
                        return imageData != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(imageData, height: 150, width: double.infinity, fit: BoxFit.cover),
                        )
                            : widget.banner.imageUrl.isNotEmpty
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(widget.banner.imageUrl, height: 150, width: double.infinity, fit: BoxFit.cover),
                        )
                            : SizedBox();
                      },
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(primaryColor),
                            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))))
                          ),
                          onPressed: () async{
                        ActionProvider.stopLoading();
                        final ImagePicker picker = ImagePicker();
                        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                        if (pickedFile != null) {
                          Uint8List newImage = await pickedFile.readAsBytes();
                          imageNotifier.value = newImage;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Image selected successfully!')),
                          );
                        }
                      }, child: AppTextWidget(text: 'Change Image',color: Colors.white,)),
                    ),
                    SizedBox(height: 10),

                    // Save Button
                    ButtonWidget(
                      text: 'Save',
                      onClicked: () async {
                        final cloudinaryProvider = Provider.of<CloudinaryProvider>(context, listen: false);
                        ActionProvider.startLoading();
                        if (imageNotifier.value != null) {
                          await cloudinaryProvider.uploadImage(imageNotifier.value!); // Upload image
                        }
                        String updatedImageUrl = cloudinaryProvider.imageUrl.isNotEmpty
                            ? cloudinaryProvider.imageUrl
                            : widget.banner.imageUrl;

                        await FirebaseFirestore.instance.collection('banner').doc(widget.banner.id).update({
                          'title': titleController.text,
                          'description': descriptionController.text,
                          'imageUrl': updatedImageUrl,
                        });
                        context.read<BannerProvider>().fetchBanners();
                        ActionProvider.stopLoading();
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      width: double.infinity,
                      height: 40,
                      fontWeight: FontWeight.w500,
                      radius: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.banner.title),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Edit') {
                _showEditDialog();
              } else if (value == 'Delete') {
                _deleteBanner();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: "Edit", child: Text("Edit")),
              PopupMenuItem(value: "Delete", child: Text("Delete")),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.banner.imageUrl,
                height: 250,
                width: 300,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              Text(widget.banner.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(widget.banner.description, style: TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
