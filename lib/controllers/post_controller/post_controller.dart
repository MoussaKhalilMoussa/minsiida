import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/category_controller/category_contorller.dart';
import 'package:simple_nav_bar/controllers/delivery_controller/delivery_controller.dart';
import 'package:simple_nav_bar/controllers/details_page_controller/details_page_controller.dart';
import 'package:simple_nav_bar/controllers/location_controller/location_controller.dart';
import 'package:simple_nav_bar/controllers/photo_controller/photos_controller.dart';
import 'package:simple_nav_bar/controllers/profile_controllers/profile/profile_controller.dart';
import 'package:simple_nav_bar/controllers/specifications_controller/specification_controller.dart';
import 'package:simple_nav_bar/models/post.dart';
import 'package:simple_nav_bar/services/auth_service/auth_service_imple.dart';
import 'package:simple_nav_bar/services/post_service/post_service_impl.dart';
import 'package:simple_nav_bar/utiles/logger.dart';
import 'package:simple_nav_bar/utiles/utitlity_functions.dart';
import 'package:simple_nav_bar/view/categories/models/category.dart';
import 'package:simple_nav_bar/view/profile/pages/mes_annonces_page.dart';
import 'package:uuid/uuid.dart';

class PostController extends GetxController {
  final postService = Get.put<PostServiceImpl>(PostServiceImpl());
  final authService = Get.put<AuthServiceImple>(AuthServiceImple());

  final photoController = Get.find<PhotosController>();
  final categoryController = Get.find<CategoryContorller>();
  final detailsController = Get.find<DetailsPageController>();
  final locationController = Get.find<LocationController>();
  final specificationsController = Get.find<SpecificationController>();
  final deliveryController = Get.find<DeliveryController>();
  final profileController = Get.find<ProfileController>();

  //late final UserProfile user;
  int get currentUserId => profileController.userProfile.value?.id ?? 0;

  // Create a singleton instance
  // firebase storage instance
  final firebaseStorage = FirebaseStorage.instance;

  // images are stored in firebase as a downloadable URLs
  List<String> _imageUrls = [];

  // loading status
  final RxBool _isLoading = false.obs;

  // uploading status
  final RxBool _isUploading = false.obs;

  var myAdds = <Post>[].obs;

  RxList<Post> myAds = <Post>[].obs;

  List<String> get imageUrls => _imageUrls;
  bool get isLoading => _isLoading.value;
  bool get isUploading => _isUploading.value;

  /* 
      R E A D      I M A G E S 
  */

  Future<void> fetchImagesUrls() async {
    // get the list under the directory: firebase_uploaded_images/
    final ListResult result =
        await firebaseStorage.ref('minsiida_post_images/').listAll();

    // get the download url for each image
    final urls = await Future.wait(
      result.items.map((ref) => ref.getDownloadURL()),
    );
    // update Urls
    _imageUrls = urls;
  }

  /* 
     DELETE IMAGE
     - iamges are stored as download urls
     eg: https://firebasestorage.googleapi.com/v0/b/emoussa....../firebase_uploaded_images/image-name.png

     - in order to delete, we need to know only the path of this image stored in firebase,
     ie: firebase_uploaded_images/image-name.png
  */
  Future<void> deleteImage(String imageUrl) async {
    try {
      final String path = extractPathFromUrl(imageUrl);
      await firebaseStorage.ref(path).delete();
      _imageUrls.remove(imageUrl);
      logger.info("✅ Deleted image from Firebase: $path");
    } on FirebaseException catch (e) {
      if (e.code == 'object-not-found') {
        // Image already deleted, no need to worry
        logger.warning("⚠️ Tried to delete non-existing image: $imageUrl");
      } else {
        // Other errors are still printed
        logger.severe("❌ Error deleting image: $e");
      }
    } catch (e) {
      logger.severe("❌ Unexpected error deleting image: $e");
    }
  }

  String extractPathFromUrl(String url) {
    try {
      // Parse the URL
      final uri = Uri.parse(url);

      // Firebase download URLs have the path after '/o/' and before '?alt=media'
      // Example:
      // https://firebasestorage.googleapis.com/v0/b/<bucket>/o/minsiida_post_images%2F1234_userid_uuid.png?alt=media&token=xxx
      final fullPathSegment =
          uri
              .pathSegments
              .last; // usually "minsiida_post_images%2F1234_userid_uuid.png"

      // Decode '%2F' to '/'
      final decodedPath = Uri.decodeComponent(fullPathSegment);

      return decodedPath;
    } catch (e) {
      logger.severe("❌ Failed to extract path from URL: $url, error: $e");
      return url; // fallback: return original URL
    }
  }

  Future<List<String>> uploadImage() async {
    _isUploading.value = true;
    final uuid = Uuid();
    final List<String> newUrls = [];

    try {
      for (var image in photoController.images) {
        String filePath =
            'minsiida_post_images/${DateTime.now().microsecondsSinceEpoch}_${currentUserId}_${uuid.v4()}.png';

        await firebaseStorage.ref(filePath).putFile(image);
        String downloadUrl =
            await firebaseStorage.ref(filePath).getDownloadURL();
        newUrls.add(downloadUrl);
      }
      return newUrls;
    } catch (e) {
      logger.severe("❌ Error uploading image: $e");
      return [];
    } finally {
      _isUploading.value = false;
    }
  }

  Future<dynamic> addPost({context}) async {
    _isLoading.value = true;

    // track only current upload’s URLs
    List<String> newUrls = [];

    try {
      // Step 1: resolve selected category & subcategory
      final Category selectedCategory =
          categoryController.categories[categoryController
              .selectedCategoryIndex
              .value];

      final List<Subcategory>? subcategories = selectedCategory.subcategories;
      Subcategory? selectedSubcategory = subcategories?.firstWhereOrNull(
        (cat) => cat.name == categoryController.selectedSubcategory.value,
      );

      if (selectedSubcategory == null) {
        throw Exception('Selected subcategory not found');
      }

      // Step 2: upload images → returns only current upload
      newUrls = await uploadImage();
      _imageUrls.addAll(newUrls);

      // Step 3: build mediaUrls for backend
      List<MediaUrl> mediaUrls =
          newUrls.map((url) => MediaUrl(content: url)).toList();

      // Step 4: create Post object
      Post post = Post(
        categoryId: selectedCategory.id,
        userId: currentUserId,
        title: detailsController.titleController.text,
        description: detailsController.descController.text,
        price: double.tryParse(detailsController.priceController.text),
        //date: formatShortDate(DateTime.now().toIso8601String()),
        subCategoryId: selectedSubcategory.id,
        productCondition: specificationsController.selectedCondition.value,
        characteristics: [
          Characteristics(
            key: "model",
            value: specificationsController.selectedModel.value,
          ),
          Characteristics(
            key: "stockage",
            value: specificationsController.selectedStorage.value,
          ),
          Characteristics(
            key: "couleur",
            value: specificationsController.selectedColor.value,
          ),
          Characteristics(
            key: "etat de la batterie",
            value: specificationsController.selectedBateryState.value,
          ),
          Characteristics(
            key: "garantie",
            value: specificationsController.selectedGuarantee.value,
          ),
        ],
        mediaUrls: mediaUrls,
      );

      // Step 5: send post to backend
      var response = await postService.addPost(post, context);

      // If backend failed → clean up
      if (response == null || response == false) {
        await rollbackImages(newUrls);
        throw Exception("Backend rejected the post");
      }

      logger.info("✅ Post created successfully!");

      Get.dialog(
        Dialog(
          backgroundColor: whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Annonce Publié",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(color: blackColor2),
                ),
                const SizedBox(height: 16),
                Icon(Ionicons.checkbox, color: greenColor, size: 48),
              ],
            ),
          ),
        ),
        barrierDismissible: true,
      );

      /* Navigator.pop(context);
      Get.off(() => MesAnnoncesPage()); */
      
      Future.delayed(const Duration(seconds: 2), () {
        Get.back(); // close dialog
        Get.off(() => MesAnnoncesPage());
      });
      photoController.selectedImages.clear();
      categoryController.clear();
      photoController.isError.value = false;
      detailsController.resetFields();
      locationController.resetSelection();
      deliveryController.resetFields();
      specificationsController.resetSelection();

      return response;
    } catch (e) {
      logger.severe("❌ addPost error: $e");
      await rollbackImages(newUrls); // rollback if any exception
      return null;
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> rollbackImages(List<String> urls) async {
    if (urls.isEmpty) return;

    logger.info("✅ Rolling back uploaded images...");

    for (var imageUrl in urls) {
      try {
        final String path = extractPathFromUrl(imageUrl);
        await firebaseStorage.ref(path).delete();
        _imageUrls.remove(imageUrl);
        // Optional: you can remove this print if you want it fully silent
        logger.info("✅ Rolled back image: $path");
      } on FirebaseException catch (e) {
        if (e.code == 'object-not-found') {
          // Image already deleted → silently continue
        } else {
          logger.severe("❌ Error rolling back image: $e");
        }
      } catch (e) {
        logger.severe("❌ Unexpected error rolling back image: $e");
      }
    }
  }

  void getAllMyAds() async {
    try {
      final response = await postService.getAllPost(currentUserId);
      myAdds.assignAll(response);
      print("==========================");
      for (var post in myAdds) {
        logger.info(post.toString());
      }
    } catch (e) {
      logger.severe("❌ Unexpected error: $e");
    }
  }
}
