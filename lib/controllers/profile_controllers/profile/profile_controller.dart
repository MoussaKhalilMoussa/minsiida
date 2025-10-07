import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_nav_bar/constants/strings.dart';
import 'package:simple_nav_bar/services/auth_service/auth_service_imple.dart';
import 'package:simple_nav_bar/services/global_service/storage_service.dart';
import 'package:simple_nav_bar/services/user_service/user_service_impl.dart';
import 'package:simple_nav_bar/utiles/logger.dart';
import 'package:simple_nav_bar/view/profile/model/user_profile.dart';
import 'package:uuid/uuid.dart';

class ProfileController extends GetxController {
  final authService = AuthServiceImple();
  final userService = UserServiceImpl();
  //final profileController = Get.find<ProfileController>();

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var userNameController = TextEditingController();

  final firebaseStorage = FirebaseStorage.instance;
  final List<String> _imageUrls = [];
  final RxBool _isUploading = false.obs;

  final ImagePicker _picker = ImagePicker();
  Rx<File?> pickedImage = Rx<File?>(null);

  RxBool isLoading = false.obs;

  var userProfile = Rxn<UserProfile>();
  int get currentUserId => userProfile.value?.id ?? 0;

  Future<void> loadProfile() async {
    try {
      final profile = await authService.loggedInUserProfile();
      if (profile != null) {
        userProfile.value = profile;
      }
    } catch (e) {
      logger.severe("❌ Failed to load profile in profile controller: $e");
    }
  }

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

  Future<String?> uploadImage() async {
    _isUploading.value = true;
    final uuid = Uuid();
    try {
      if (pickedImage.value == null) return null; // nothing selected

      String filePath =
          'minsiida_profile_images/${DateTime.now().microsecondsSinceEpoch}_${currentUserId}_${uuid.v4()}.png';
      await firebaseStorage.ref(filePath).putFile(pickedImage.value!);
      String downloadUrl = await firebaseStorage.ref(filePath).getDownloadURL();
      return downloadUrl;
    } catch (e) {
      logger.severe("❌ Error uploading image: $e");
      return null;
    } finally {
      _isUploading.value = false;
    }
  }

  Future<UserProfile?> updateProfile({context}) async {
    isLoading.value = true;
    String? newUrl;
    try {
      newUrl = await uploadImage();

      UserProfile newUserProfile = UserProfile(
        username: userNameController.text,
        name: nameController.text,
        phone: phoneController.text,
        email: emailController.text,
        profilePicture: newUrl ?? userProfile.value?.profilePicture,
      );

      var response = await userService.updateProfile(
        newUserProfile: newUserProfile,
        userId: currentUserId,
      );

      if (response == null) {
        if (newUrl != null) await rollbackImages(newUrl);
        throw Exception("Backend rejected profile update");
      }
      return response;
    } catch (e) {
      logger.severe("❌ updateProfile error: $e");
      if (newUrl != null) await rollbackImages(newUrl);
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> rollbackImages(String urls) async {
    if (urls.isEmpty) return;

    logger.info("✅ Rolling back uploaded images...");

    try {
      final String path = extractPathFromUrl(urls);
      await firebaseStorage.ref(path).delete();
      _imageUrls.remove(urls);
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

  Future<void> pickImage() async {
    final XFile? selected = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (selected != null) {
      pickedImage.value = File(selected.path);
    }
  }

  Future<void> takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      pickedImage.value = File(photo.path);
    }
  }

  void clearUserProfile() {
    userProfile.value = null;
    StorageService.remove(authToken);
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    userNameController.dispose();
    super.onClose();
  }
}
