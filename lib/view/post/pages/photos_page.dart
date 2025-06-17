// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:simple_nav_bar/common_widgets/breadcrump.dart';

import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/photo_controller/photos_controller.dart';
import 'package:simple_nav_bar/view/post/widget/continue_button.dart';

class PhotosPage extends StatefulWidget {
  final int currentPage;
  final int index;
  final PageController controller;

  const PhotosPage({
    super.key,
    required this.currentPage,
    required this.index,
    required this.controller,
  });

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  //List<File> _images = [];
  final ImagePicker _picker = ImagePicker();

  var controller = Get.put(PhotosController());

  Future<void> _pickImages() async {
    final List<XFile> selected = await _picker.pickMultiImage();
    if (selected != null) {
      controller.isError.value = false;
      setState(() {
        //_images.addAll(selected.map((xfile) => File(xfile.path)));
        controller.selectedImages.addAll(
          selected.map((xfile) => File(xfile.path)),
        );
      });
    }
  }

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      controller.isError.value = false;
      controller.selectedImages.add(File(photo.path));
    }
  }

  // error message for no images selected
  Widget _errorMessage() {
    return Obx(() {
      return controller.isError.value
          ? Padding(
            padding: const EdgeInsets.all(8.0),

            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.sizeOf(context).width * 0.8,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.red.withValues(alpha: 0.5),
                  width: 1.5,
                ),
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "ⓘ Veuillez ajouter au moins une photo avant de continuer.",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
          : SizedBox.shrink();
    });
  }

  late int currentPage;

  @override
  void initState() {
    super.initState();
    currentPage = widget.currentPage;
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.sizeOf(context).width;
    final screenH = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            //mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Header section with title and progress bar parent
              // This section is fixed at the top of the screen
              Breadcrump(
                title: "Photos",
                currentPage: widget.currentPage,
                controller: widget.controller,
              ),
              const SizedBox(height: 30),

              Obx(() {
                final images = controller.selectedImages;
                final rows = (images.length / 3).ceil();
                final imageHeight = rows * 108.0; // 100px + 8px spacing
                final pickerHeight = MediaQuery.sizeOf(context).height * 0.35;
                final totalHeight =
                    pickerHeight + imageHeight + 100; // + extra spacing

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: screenW * 0.9,
                  //height: totalHeight,
                  constraints: BoxConstraints(minHeight: totalHeight - 4),
                  padding: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        color: Colors.grey.withValues(alpha: 0.2),
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  // And inside, we stack picker UI + images:
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // — your dotted picker section
                      DottedBorder(
                        options: RoundedRectDottedBorderOptions(
                          radius: Radius.circular(8),
                          color: Colors.grey.shade400,
                          strokeWidth: 1.5,
                          dashPattern: const [8, 4],
                        ),
                        child: Container(
                          height: screenH * 0.35,
                          width: screenW * 0.8,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.purple.withValues(alpha: 0.09),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withValues(
                                        alpha: 0.15,
                                      ),
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  onPressed: _takePhoto,
                                  icon: Icon(
                                    LucideIcons.camera,
                                    size: 28,
                                    color: Colors.purple.shade600,
                                  ),
                                  splashRadius: 28,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Ajouter des photos',
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: blackColor2,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Ajoutez des photos de votre produit pour attirer plus d\'acheteurs.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 14,
                                  //fontWeight: FontWeight.bold,
                                  color: greyColor,
                                ),
                              ),
                              const SizedBox(height: 26),
                              CustomButton(
                                borderRadius: 50,
                                onPressed: _pickImages,
                                width: MediaQuery.sizeOf(context).width * 0.45,
                                height: 45,
                                child: Row(
                                  //spacing: 4,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      LucideIcons.upload,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        'Choisir des photos',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 14),
                      Text(
                        "ⓘ Ajouter jusqu'à 12 photos en format JPG,JPEG ou PNG",
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 10,
                          //fontWeight: FontWeight.bold,
                          color: greyColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // — if no images is selected and the continue button is clickek which means
                      //widget.currentPage = widget.currentPage + 1, show an error message
                      _errorMessage(),

                      // — now the images wrap (only if present)
                      Obx(() {
                        if (controller.selectedImages.isEmpty) {
                          return SizedBox.shrink();
                        }

                        return Wrap(
                          spacing: 12,
                          runSpacing: 8,
                          children:
                              controller.selectedImages.map((img) {
                                return Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        img,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 4,
                                      right: 4,
                                      child: GestureDetector(
                                        onTap: () {
                                          controller.selectedImages.remove(img);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black.withValues(
                                              alpha: 0.5,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          padding: const EdgeInsets.all(4),
                                          child: const Icon(
                                            Icons.close,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                        );
                      }),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
