import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
import 'package:simple_nav_bar/services/user_service/user_service_impl.dart';
import 'package:simple_nav_bar/utiles/logger.dart';
import 'package:simple_nav_bar/view/categories/models/category.dart';
import 'package:simple_nav_bar/view/profile/model/user_profile.dart';
import 'package:simple_nav_bar/view/profile/pages/mes_annonces_page.dart';
import 'package:uuid/uuid.dart';
import 'package:velocity_x/velocity_x.dart';

class PostController extends GetxController {
  final postService = Get.put<PostServiceImpl>(PostServiceImpl());
  final authService = Get.put<AuthServiceImple>(AuthServiceImple());
  final userService = Get.put<UserServiceImpl>(UserServiceImpl());

  final photoController = Get.find<PhotosController>();
  final categoryController = Get.find<CategoryContorller>();
  final detailsController = Get.find<DetailsPageController>();
  final locationController = Get.find<LocationController>();
  final specificationsController = Get.find<SpecificationController>();
  final deliveryController = Get.find<DeliveryController>();
  final profileController = Get.find<ProfileController>();
  //final homeController = Get.find<HomeController>();

  //late final UserProfile user;
  int get currentUserId => profileController.userProfile.value?.id ?? 0;

  // Create a singleton instance
  // firebase storage instance
  final firebaseStorage = FirebaseStorage.instance;

  // images are stored in firebase as a downloadable URLs
  List<String> _imageUrls = [];

  // loading status
  final RxBool _isLoading = false.obs;
  final RxBool myAddsLoading = false.obs;
  final RxBool isDeleting = false.obs;

  // uploading status
  final RxBool _isUploading = false.obs;

  // === Main lists ===
  final myAdds = <Post>[].obs;
  final myFavoritePosts = <Post>[].obs;

  // === Filtered lists (search results) ===
  final filteredAdds = <Post>[].obs;
  final filteredFavoris = <Post>[].obs;

  // === Search query ===
  final adsSearchQuery = ''.obs;
  final favoritesSearchQuery = ''.obs;

  // === Debounce worker ===
  Worker? _debounceWorker;

  final postsByCategoryNameOrId = <Post>[].obs;
  final featuredPosts = <Post>[].obs;
  final trendingPosts = <Post>[].obs;
  final suggestedPosts = <Post>[].obs;

  final announce = RxnString();

  final totalElements = 0.obs;
  final pageSize = 0.obs;
  final pageNumber = 0.obs;
  final totalPages = 0.obs;

  final isLoadingCategoryPosts = false.obs;
  final isLoadingStatusPosts = false.obs;
  var featuredPostsloading = false.obs;
  var trendingPostsloading = false.obs;
  var suggestedPostsloading = false.obs;

  final errorMessage = RxnString();

  //final myFavoritePosts = <Post>[].obs;
  var usersOfLikedPosts = <int, UserProfile>{}.obs; // map userId → UserProfile
  final RxSet<int> likedPostIds = <int>{}.obs;
  final RxBool myFavoritePostsLoading = false.obs;

  final isFavoritePost = false.obs;

  List<String> get imageUrls => _imageUrls;
  bool get isLoading => _isLoading.value;
  bool get isUploading => _isUploading.value;

  final _reportController = TextEditingController();
  final RxBool isReportLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initSearchDebounce();
  }

  void _initSearchDebounce() {
    _debounceWorker?.dispose();

    // Debounce both search fields (waits 400ms after typing)
    _debounceWorker = debounce(
      adsSearchQuery,
      (_) => searchMyAds(adsSearchQuery.value),
      time: const Duration(milliseconds: 400),
    );

    // Optional: If I have a separate search bar for favorites
    debounce(
      favoritesSearchQuery,
      (_) => searchMyFavorites(favoritesSearchQuery.value),
      time: const Duration(milliseconds: 400),
    );
  }

  @override
  void onClose() {
    _debounceWorker?.dispose();
    super.onClose();
  }

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

  void getAllMyPosts() async {
    try {
      myAddsLoading.value = true;
      final response = await postService.getAllMyPosts(currentUserId);
      myAdds.assignAll(response);
      filteredAdds.assignAll(response);
    } catch (e) {
      logger.severe("❌ Unexpected error in getAllMyPosts post controller: $e");
      myAdds.assignAll([]); // ensure safe state
    } finally {
      myAddsLoading.value = false;
    }
  }

  // Search in user's own posts
  void searchMyAds(String query) {
    if (query.trim().isEmpty) {
      resetAdsSearch();
      return;
    }

    final lowerQuery = query.toLowerCase();

    final results =
        myAdds.where((post) {
          final inTitle =
              post.title?.toLowerCase().contains(lowerQuery) ?? false;
          final inDescription =
              post.description?.toLowerCase().contains(lowerQuery) ?? false;
          final inPrice = post.price?.toString().contains(lowerQuery) ?? false;
          final inCharacteristics =
              post.characteristics?.any(
                (c) =>
                    (c.key?.toLowerCase().contains(lowerQuery) ?? false) ||
                    (c.value?.toLowerCase().contains(lowerQuery) ?? false),
              ) ??
              false;

          return inTitle || inDescription || inPrice || inCharacteristics;
        }).toList();

    filteredAdds.assignAll(results);
  }

  // Search in favorites
  void searchMyFavorites(String query) {
    if (query.trim().isEmpty) {
      resetFavoritesSearch();
      return;
    }

    final lowerQuery = query.toLowerCase();

    final results =
        myFavoritePosts.where((post) {
          final inTitle =
              post.title?.toLowerCase().contains(lowerQuery) ?? false;
          final inDescription =
              post.description?.toLowerCase().contains(lowerQuery) ?? false;
          final userName = usersOfLikedPosts[post.userId]?.name ?? "";
          final inUserName = userName.toLowerCase().contains(lowerQuery);
          final inPrice = post.price?.toString().contains(lowerQuery) ?? false;
          final inCharacteristics =
              post.characteristics?.any(
                (c) =>
                    (c.key?.toLowerCase().contains(lowerQuery) ?? false) ||
                    (c.value?.toLowerCase().contains(lowerQuery) ?? false),
              ) ??
              false;

          return inTitle ||
              inDescription ||
              inUserName ||
              inPrice ||
              inCharacteristics;
        }).toList();

    filteredFavoris.assignAll(results);
  }

  Future<void> getAllMyFavoritePosts() async {
    try {
      myFavoritePostsLoading.value = true;
      final response = await postService.getMyFavoritesPosts(
        userId: currentUserId,
      );
      myFavoritePosts.assignAll(response);
      likedPostIds.addAll(response.map((p) => p.id!));
      filteredFavoris.assignAll(response);

      for (var post in myFavoritePosts) {
        if (post.userId != null &&
            !usersOfLikedPosts.containsKey(post.userId)) {
          usersOfLikedPosts[post.userId!] = await userService.getUser(
            userId: post.userId!,
          );
          usersOfLikedPosts.refresh();
        }
      }
      //filteredAdds.assignAll(response); // default: all
      myFavoritePostsLoading.value = false;
    } catch (e) {
      logger.severe(
        "❌ Unexpected error in getAllMyFavoritePosts post controller: $e",
      );
    }
  }

  final RxBool isLiked = false.obs;

  bool isPostLiked(int postId) => likedPostIds.contains(postId);

  void toggleLike(Post post) async {
    final wasLiked = isPostLiked(post.id!);

    // Optimistic update → UI changes immediately
    for (var post in myFavoritePosts) {
      if (post.userId != null && !usersOfLikedPosts.containsKey(post.userId)) {
        usersOfLikedPosts[post.userId!] = await userService.getUser(
          userId: post.userId!,
        );
        usersOfLikedPosts.refresh();
      }
    }
    if (wasLiked) {
      likedPostIds.remove(post.id!);
      myFavoritePosts.remove(post);
    } else {
      likedPostIds.add(post.id!);
      myFavoritePosts.add(post);
    }

    // keep filteredFavoris in sync with myFavoritePosts
    filteredFavoris.assignAll(myFavoritePosts);
    try {
      if (wasLiked) {
        await postService.unlikePost(postId: post.id!, userId: currentUserId);
      } else {
        await postService.likePost(postId: post.id!, userId: currentUserId);
      }
    } catch (e) {
      // Rollback if API fails
      if (wasLiked) {
        likedPostIds.add(post.id!);
        myFavoritePosts.add(post);
      } else {
        likedPostIds.remove(post.id!);
        myFavoritePosts.remove(post);
      }
      filteredFavoris.assignAll(myFavoritePosts);
      logger.severe("❌ Failed to sync like: $e");
    }
  }

  Future<void> getPostsByCategoryNameorId({required int categoryId}) async {
    try {
      isLoadingCategoryPosts.value = true;
      errorMessage.value = null;

      final response = await postService.getPostsByCategoryNameOrId(
        categoryId: categoryId,
      );
      postsByCategoryNameOrId.clear();

      if (response == null) {
        errorMessage.value = "Pas d'annonce trouvée";
      } else {
        //postsByCategoryNameOrId.assignAll(response);
        setPosts(response.content!);
        totalElements.value = response.page!.totalElements!;
        pageSize.value = response.page!.size!;
        pageNumber.value = response.page!.number!;
        totalPages.value = response.page!.totalPages!;
      }
    } catch (e) {
      logger.severe("❌ Unexpected error in getPostsByCategoryNameOrId: $e");
      errorMessage.value = "Erreur de chargement des annonces.";
    } finally {
      isLoadingCategoryPosts.value = false;
    }
  }

  Future<void> getPostsByCategoryNameorIdForShowMore({
    required int categoryId,
    int? page,
    int? size,
  }) async {
    try {
      errorMessage.value = null;

      final response = await postService.getPostsByCategoryNameOrId(
        categoryId: categoryId,
        page: page,
        size: size,
      );
      postsByCategoryNameOrId.clear();
      totalElements.value = 0;
      pageSize.value = 0;
      pageNumber.value = 0;
      totalPages.value = 0;

      if (response == null) {
        errorMessage.value = "Pas d'annonce trouvée";
      } else {
        //postsByCategoryNameOrId.assignAll(response);
        //setPosts(response.content!);
        postsByCategoryNameOrId.assignAll(response.content!);
        totalElements.value = response.page!.totalElements!;
        pageSize.value = response.page!.size!;
        pageNumber.value = response.page!.number!;
        totalPages.value = response.page!.totalPages!;
      }
    } catch (e) {
      logger.severe("❌ Unexpected error in getPostsByCategoryNameOrId: $e");
      errorMessage.value = "Erreur de chargement des annonces.";
    }
  }

  Future<void> getAllPostsByStatus({
    required String status,
    int? page,
    int? size,
  }) async {
    try {
      isLoadingStatusPosts.value = true;
      errorMessage.value = null;

      final response = await postService.getPostsByStatus(status: status);
      // here we are using status to get all posts
      postsByCategoryNameOrId.clear();

      if (response == null) {
        errorMessage.value = "Pas d'annonce trouvée";
      } else {
        //postsByCategoryNameOrId.assignAll(response);
        setPosts(response.content!);
        totalElements.value = response.page!.totalElements!;
        pageSize.value = response.page!.size!;
        pageNumber.value = response.page!.number!;
        totalPages.value = response.page!.totalPages!;
      }
    } catch (e) {
      logger.severe("❌ Unexpected error in getAllPostsByStatus: $e");
      errorMessage.value = "Erreur de chargement des annonces.";
    } finally {
      isLoadingStatusPosts.value = false;
    }
  }

  Future<void> getAllPostsByStatusForShowMore({
    required String status,
    int? page,
    int? size,
  }) async {
    try {
      errorMessage.value = null;
      final response = await postService.getPostsByStatus(
        status: status,
        page: page,
        size: size,
      );
      // here we are using status to get all posts
      postsByCategoryNameOrId.clear();
      totalElements.value = 0;
      pageSize.value = 0;
      pageNumber.value = 0;
      totalPages.value = 0;

      if (response == null) {
        errorMessage.value = "Pas d'annonce trouvée";
      } else {
        postsByCategoryNameOrId.assignAll(response.content!);
        totalElements.value = response.page!.totalElements!;
        pageSize.value = response.page!.size!;
        pageNumber.value = response.page!.number!;
        totalPages.value = response.page!.totalPages!;
      }
    } catch (e) {
      logger.severe("❌ Unexpected error in getAllPostsByStatus: $e");
      errorMessage.value = "Erreur de chargement des annonces.";
    }
  }

  Future<void> getFeaturedPosts() async {
    try {
      featuredPostsloading.value = true;
      errorMessage.value = null;

      final response = await postService.getFeaturedPosts();
      featuredPosts.clear();

      if (response == null) {
        errorMessage.value = "Pas d'annonce trouvée";
      } else {
        featuredPosts.assignAll(response.content!);
        visibleCount.value = 10;
        totalElements.value = response.page!.totalElements!;
        pageSize.value = response.page!.size!;
        pageNumber.value = response.page!.number!;
        totalPages.value = response.page!.totalPages!;
      }
    } catch (e) {
      logger.severe("❌ Unexpected error in getFeaturedPosts: $e");
      errorMessage.value = "Erreur de chargement des annonces.";
    } finally {
      featuredPostsloading.value = false;
    }
  }

  Future<void> getFeaturedPostsForShowMore({int? page, int? size}) async {
    try {
      errorMessage.value = null;
      final response = await postService.getFeaturedPosts(
        page: page,
        size: size,
      );

      featuredPosts.clear();
      totalElements.value = 0;
      pageSize.value = 0;
      pageNumber.value = 0;
      totalPages.value = 0;
      if (response == null) {
        errorMessage.value = "Pas d'annonce trouvée";
      } else {
        //postsByCategoryNameOrId.assignAll(response);
        featuredPosts.assignAll(response.content!);
        totalElements.value = response.page!.totalElements!;
        pageSize.value = response.page!.size!;
        pageNumber.value = response.page!.number!;
        totalPages.value = response.page!.totalPages!;
      }
    } catch (e) {
      logger.severe("❌ Unexpected error in getFeaturedPosts: $e");
      errorMessage.value = "Erreur de chargement des annonces.";
    }
  }

  Future<void> getTrendingPosts({int? page, int? size}) async {
    try {
      trendingPostsloading.value = true;
      errorMessage.value = null;

      final response = await postService.getTrendingPosts(
        page: page,
        size: size,
      );
      trendingPosts.clear();

      if (response == null) {
        errorMessage.value = "Pas d'annonce trouvée";
      } else {
        trendingPosts.assignAll(response.content!);
        visibleCount.value = 10;
        totalElements.value = response.page!.totalElements!;
        pageSize.value = response.page!.size!;
        pageNumber.value = response.page!.number!;
        totalPages.value = response.page!.totalPages!;
      }
    } catch (e) {
      logger.severe("❌ Unexpected error in getFeaturedPosts: $e");
      errorMessage.value = "Erreur de chargement des annonces.";
    } finally {
      trendingPostsloading.value = false;
    }
  }

  Future<void> getTrendingPostsForShowMore({int? page, int? size}) async {
    try {
      errorMessage.value = null;
      final response = await postService.getTrendingPosts(
        page: page,
        size: size,
      );

      trendingPosts.clear();
      totalElements.value = 0;
      pageSize.value = 0;
      pageNumber.value = 0;
      totalPages.value = 0;
      if (response == null) {
        errorMessage.value = "Pas d'annonce trouvée";
      } else {
        //postsByCategoryNameOrId.assignAll(response);
        trendingPosts.assignAll(response.content!);
        totalElements.value = response.page!.totalElements!;
        pageSize.value = response.page!.size!;
        pageNumber.value = response.page!.number!;
        totalPages.value = response.page!.totalPages!;
      }
    } catch (e) {
      logger.severe("❌ Unexpected error in getFeaturedPosts: $e");
      errorMessage.value = "Erreur de chargement des annonces.";
    }
  }

  Future<void> getSuggestedPosts() async {
    try {
      suggestedPostsloading.value = true;
      errorMessage.value = null;

      final response = await postService.getSuggestedPosts(
        userId: profileController.userProfile.value!.id!,
      );
      suggestedPosts.clear();

      if (response == null) {
        errorMessage.value = "Pas d'annonce trouvée";
      } else {
        suggestedPosts.assignAll(response.content!);
        visibleCount.value = 10;
        totalElements.value = response.page!.totalElements!;
        pageSize.value = response.page!.size!;
        pageNumber.value = response.page!.number!;
        totalPages.value = response.page!.totalPages!;
      }
    } catch (e) {
      logger.severe(
        "❌ Unexpected error in homeController getSuggestedPosts: $e",
      );
      errorMessage.value = "Erreur de chargement des annonces.";
    } finally {
      suggestedPostsloading.value = false;
    }
  }

  Future<void> getSuggestedPostsForShowMore({int? page, int? size}) async {
    try {
      errorMessage.value = null;
      final response = await postService.getSuggestedPosts(
        userId: profileController.userProfile.value!.id!,
        page: page,
        size: size,
      );

      suggestedPosts.clear();
      totalElements.value = 0;
      pageSize.value = 0;
      pageNumber.value = 0;
      totalPages.value = 0;
      if (response == null) {
        errorMessage.value = "Pas d'annonce trouvée";
      } else {
        //postsByCategoryNameOrId.assignAll(response);
        suggestedPosts.assignAll(response.content!);
        totalElements.value = response.page!.totalElements!;
        pageSize.value = response.page!.size!;
        pageNumber.value = response.page!.number!;
        totalPages.value = response.page!.totalPages!;
      }
    } catch (e) {
      logger.severe("❌ Unexpected error in getFeaturedPosts: $e");
      errorMessage.value = "Erreur de chargement des annonces.";
    }
  }

  void viewPost({required int postId}) async {
    try {
      await postService.viewPost(postId: postId);
    } catch (e) {
      logger.severe("❌ Unexpected error in viewPost postController: $e");
    }
  }

  void _reportPost({
    required int postId,
    required int userId,
    required String reason,
  }) async {
    try {
      isReportLoading.value = true;
      var text = await postService.reportPost(
        postId: postId,
        userId: userId,
        reason: reason,
      );
      if (text!.isNotEmpty) {
        Navigator.of(Get.context!).pop(); // Close dialog
        Get.snackbar(
          "Reussit",
          text,
          backgroundColor: greenColor.withValues(alpha: .5),
          duration: Duration(seconds: 5),
        );
      } else {
        Get.snackbar(
          "Erreur",
          "Une erreur s'est produite!",
          backgroundColor: redColor.withValues(alpha: .5),
          duration: Duration(seconds: 5),
        );
      }
    } catch (e) {
      Get.snackbar("Erreur", "$e");
      logger.severe("❌ Unexpected error in reportPost postController: $e");
    } finally {
      isReportLoading.value = false;
    }
  }

  void openReportDialog({required int postId}) {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8),
          ),
          backgroundColor: whiteColor,
          title: const Text("Signaler"),
          content: TextField(
            controller: _reportController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: "Decrire un suject ...",
              border: OutlineInputBorder(),
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              onPressed:
                  isReportLoading.value
                      ? null
                      : () {
                        Navigator.of(context).pop();
                        _reportController.clear();
                      },
              child: Text(
                "Annuler",
                style: GoogleFonts.poppins(color: greyColor),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(shape: WidgetStatePropertyAll(LinearBorder())),
              onPressed:
                  isReportLoading.value
                      ? null
                      : () {
                        final reason = _reportController.text.trim();
                        if (reason.isNotEmpty) {
                          _reportPost(
                            reason: reason,
                            userId: currentUserId,
                            postId: postId,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please write a report reason"),
                            ),
                          );
                        }
                      },
              child:
                  isReportLoading.value
                      ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                      : Text(
                        "Envoyer",
                        style: GoogleFonts.poppins(color: greyColor),
                      ),
            ),
          ],
        );
      },
    );
  }

  void deletePost({required int postId}) async {
    try {
      errorMessage.value = "";
      isDeleting.value = true;
      final String? response = await postService.deletePost(postId: postId);
      if (response == null) {
        errorMessage.value = "echec de suppression";
        Get.snackbar(
          maxWidth: Get.context!.screenWidth - 40,
          backgroundColor: frindlyErrorColor,
          colorText: blackColor2,
          duration: Duration(seconds: 3),
          "Echec",
          errorMessage.value!,
          snackPosition: SnackPosition.TOP,
        );
        isDeleting.value = false;
      } else {
        myAdds.removeWhere((post) => post.id == postId);
        filteredAdds.removeWhere((post) => post.id == postId);
        Get.snackbar(
          maxWidth: Get.context!.screenWidth - 40,
          colorText: blackColor2,
          duration: Duration(seconds: 3),
          "Supprimer",
          "Supprimer avec succee",
          snackPosition: SnackPosition.TOP,
        );
        //getAllMyPosts();
      }
    } catch (e) {
      logger.severe("❌ Unexpected error in deletePost: $e");
    }
  }

  //final visibleCount = 24.obs;
  final visibleCount = 0.obs;
  final isLoadingMore = false.obs;

  bool get isAllVisible => visibleCount.value >= totalElements.value;

  void showMore({int step = 10}) async {
    if (isAllVisible) return;
    isLoadingMore.value = true;

    if (categoryController.selectedCategoryName.value == "Tous") {
      int size = pageSize.value;
      if (visibleCount.value < totalElements.value) {
        size += 10;

        await getAllPostsByStatusForShowMore(status: "all", size: size);
        visibleCount.value = min(
          visibleCount.value + step,
          totalElements.value,
        );
      }
    } else if (categoryController.selectedCategoryName.value == "vedette") {
      int size = pageSize.value;

      if (visibleCount.value < totalElements.value) {
        size += 10;

        await getFeaturedPostsForShowMore(size: size);
        visibleCount.value = min(
          visibleCount.value + step,
          totalElements.value,
        );
      }
    } else if (categoryController.selectedCategoryName.value ==
        "recommandees") {
      int size = pageSize.value;

      if (visibleCount.value < totalElements.value &&
          size < totalElements.value) {
        size += 10;

        await getSuggestedPostsForShowMore(size: size);
        visibleCount.value = min(
          visibleCount.value + step,
          totalElements.value,
        );
      } else {
        visibleCount.value = totalElements.value;
      }
    } else if (categoryController.selectedCategoryName.value == "populaires") {
      int size = pageSize.value;

      if (visibleCount.value < totalElements.value) {
        size += 10;

        await getTrendingPostsForShowMore(size: size);
        visibleCount.value = min(
          visibleCount.value + step,
          totalElements.value,
        );
      }
    } else {
      //await Future.delayed(const Duration(milliseconds: 300)); // simulate delay
      int size = pageSize.value;
      if (visibleCount.value < totalElements.value) {
        size += 10;
        await getPostsByCategoryNameorIdForShowMore(
          categoryId: categoryController.selectedCategoryId.value,
          size: size,
        );
        visibleCount.value = min(
          visibleCount.value + step,
          totalElements.value,
        );
        print("getAllPostsByStatusForShowMore 4 ${visibleCount.value}");
      }
    }
    isLoadingMore.value = false;
  }

  // Call this after you fetch posts
  void setPosts(List<Post> posts) {
    postsByCategoryNameOrId.assignAll(posts);
    // reset visible count to initial or clamp if there are fewer posts
    visibleCount.value = 10;
  }

  void resetAdsSearch() {
    filteredAdds.assignAll(myAdds);
  }

  void resetFavoritesSearch() {
    filteredFavoris.assignAll(myFavoritePosts);
  }

  void clearAllSearch() {
    adsSearchQuery.value = '';
    favoritesSearchQuery.value = '';
    resetAdsSearch();
    resetFavoritesSearch();
  }
}
