import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simple_nav_bar/controllers/category_controller/category_contorller.dart';
import 'package:simple_nav_bar/controllers/delivery_controller/delivery_controller.dart';
import 'package:simple_nav_bar/controllers/details_page_controller/details_page_controller.dart';
import 'package:simple_nav_bar/controllers/location_controller/location_controller.dart';
import 'package:simple_nav_bar/controllers/photo_controller/photos_controller.dart';
import 'package:simple_nav_bar/controllers/specifications_controller/specification_controller.dart';
import 'package:simple_nav_bar/models/post.dart';
import 'package:simple_nav_bar/services/auth_service/auth_service_imple.dart';
import 'package:simple_nav_bar/services/post_service/post_service_impl.dart';
import 'package:simple_nav_bar/utiles/utitlity_functions.dart';
import 'package:simple_nav_bar/view/categories/models/category.dart';
import 'package:simple_nav_bar/view/profile/model/user_profile.dart';

class PostController extends GetxController {
  final postService = Get.put<PostServiceImpl>(PostServiceImpl());
  final authService = Get.put<AuthServiceImple>(AuthServiceImple());

  final photoController = Get.find<PhotosController>();
  final categoryController = Get.find<CategoryContorller>();
  final detailsController = Get.find<DetailsPageController>();
  final locationController = Get.find<LocationController>();
  final specificationsController = Get.find<SpecificationController>();
  final deliveryController = Get.find<DeliveryController>();

  late final UserProfile user;
  // Create a singleton instance
  // firebase storage instance
  final firebaseStorage = FirebaseStorage.instance;

  // images are stored in firebase as a downloadable URLs
  List<String> _imageUrls = [];

  // loading status
  final RxBool _isLoading = false.obs;

  // uploading status
  final RxBool _isUploading = false.obs;

  /* 
    G E T T E R S
  */

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
      print("✅ Deleted image from Firebase: $path");
    } catch (e) {
      print("❌ Error deleting image: $e");
    }
  }

  String extractPathFromUrl(String url) {
    final uri = Uri.parse(url);
    final pathIndex = uri.pathSegments.indexOf("o");
    if (pathIndex != -1 && pathIndex + 1 < uri.pathSegments.length) {
      return Uri.decodeComponent(uri.pathSegments[pathIndex + 1]);
    }
    return Uri.decodeComponent(uri.pathSegments.last);
  }

  Future<void> uploadImage() async {
    // start uploading
    _isUploading.value = true;

    try {
      // defining the path in storage
      //String filePath = 'product_images/${DateTime.now().microsecondsSinceEpoch + user.id!}.png';
      // upload the file to firebase storage
      for (var image in photoController.images) {
        String filePath =
            'minsiida_post_images/${DateTime.now().microsecondsSinceEpoch}_${user.id}_${photoController.images.indexOf(image)}.png';
        await firebaseStorage.ref(filePath).putFile(image);
        String downloadUrl =
            await firebaseStorage.ref(filePath).getDownloadURL();
        _imageUrls.add(downloadUrl);
      }
    } catch (e) {
      // handle any error
      print("Error uploading image: $e");
    } finally {
      _isUploading.value = false;
      //notifyListeners();
    }
  }

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  void getProfile() async {
    user = await authService.profile();
  }

  Future<dynamic> addPost({context}) async {
    _isLoading.value = true;

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

      // Step 2: upload images
      await uploadImage();
      await fetchImagesUrls();

      // Step 3: prepare mediaUrls for backend
      List<MediaUrl> mediaUrls =
          _imageUrls.map((url) => MediaUrl(content: url)).toList();

      // Step 4: create Post object
      Post post = Post(
        categoryId: selectedCategory.id,
        userId: user.id,
        title: detailsController.titleController.text,
        description: detailsController.descController.text,
        price: int.tryParse(detailsController.priceController.text),
        date: formatShortDate(DateTime.now().toIso8601String()),
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
        await rollbackImages();
        throw Exception("Backend rejected the post");
      }

      print("✅ Post created successfully!");
      return response;
    } catch (e) {
      print("❌ addPost error: $e");
      await rollbackImages(); // rollback if any exception
      return null;
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> rollbackImages() async {
    print("⚠️ Rolling back uploaded images...");

    for (var imageUrl in List<String>.from(_imageUrls)) {
      await deleteImage(imageUrl);
    }

    _imageUrls.clear();
  }
}
