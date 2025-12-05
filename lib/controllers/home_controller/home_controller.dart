import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_nav_bar/controllers/profile_controllers/profile/profile_controller.dart';
import 'package:simple_nav_bar/models/post.dart';
import 'package:simple_nav_bar/services/post_service/post_service_impl.dart';
import 'package:simple_nav_bar/services/user_service/user_service_impl.dart';
import 'package:simple_nav_bar/utiles/logger.dart';
import 'package:simple_nav_bar/view/profile/model/user_profile.dart';

class HomeController extends GetxController {
  RxInt homeIndex = 0.obs;
  var isFilterDrawerOpen = false.obs;
  var selectedIndex = 0.obs;

  var isSelected = false.obs;
  var selectedSubCategory = ''.obs;

  final leftController = TextEditingController();
  final rightController = TextEditingController();

  var selectedPreset = ''.obs; // Tracks which preset is selected

  RxList<Post> featuredPosts = <Post>[].obs;
  var usersForfeaturedPosts =
      <int, UserProfile>{}.obs; // map userId → UserProfile

  RxList<Post> trendingPosts = <Post>[].obs;
  var usersFortrendingPosts =
      <int, UserProfile>{}.obs; // map userId → UserProfile

  RxList<Post> suggestedPosts = <Post>[].obs;
  var usersForSuggestedPosts =
      <int, UserProfile>{}.obs; // map userId → UserProfile

  var featuredPostsloading = false.obs;
  var trendingPostsloading = false.obs;
  var suggestedPostsloading = false.obs;

  final errorMessageForFeatured = RxnString();
  final errorMessageForTrending = RxnString();
  final errorMessageForSuggest = RxnString();

  var fakeFeaturedPostsloading = false.obs;
  var fakeTrendingPostsloading = false.obs;
  var fakeSuggestedPostsloading = false.obs;

  final postService = Get.put<PostServiceImpl>(PostServiceImpl());
  final userService = Get.put<UserServiceImpl>(UserServiceImpl());
  final profileController = Get.find<ProfileController>();

  // the track prix textfields
  var isFocusedLeftField = false.obs;
  void setLeftFieldFocus(bool value) {
    isFocusedLeftField.value = value;
    selectedPreset.value = '';
  }

  var isFocusedRightField = false.obs;
  void setRightFieldFocus(bool value) {
    isFocusedRightField.value = value;
    selectedPreset.value = '';
  }

  // Filtrer par mot-clé
  var selectedDayFilter = ''.obs;

  // Note vendeur
  var selectedVendor = ''.obs;

  // research field on filter
  final keywordFocus = FocusNode();
  var isKeywordFocused = false.obs;

  final keywordController = TextEditingController();
  var keywordText = ''.obs;

  Timer? _debounce;

  // selection une vill reseaech field
  var cityKeywordText = ''.obs;
  final cityKeywordController = TextEditingController();
  final cityKeywordFocus = FocusNode();
  var isCityKeywordFocused = false.obs;
  Timer? _cityDebounce;

  @override
  void onInit() {
    super.onInit();
    keywordFocus.addListener(() {
      isKeywordFocused.value = keywordFocus.hasFocus;
    });

    cityKeywordFocus.addListener(() {
      isCityKeywordFocused.value = cityKeywordFocus.hasFocus;
    });

    keywordController.addListener(() {
      final text = keywordController.text;
      keywordText.value = text;

      // Debounce search logic
      _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 300), () {
        onKeywordSearch(text);
      });
    });

    cityKeywordController.addListener(() {
      final text = cityKeywordController.text;
      cityKeywordText.value = text;

      // Debounce search logic
      _cityDebounce?.cancel();
      _cityDebounce = Timer(const Duration(milliseconds: 300), () {
        onCityKeywordSearch(text);
      });
    });
  }

  void onKeywordSearch(String text) {
    // Implement your filtering logic here
    print('Searching for: $text');
  }

  void onCityKeywordSearch(String text) {
    // Implement your filtering logic here
    print('Searching for: $text');
  }

  void clearKeyword() {
    keywordController.clear();
  }

  void clearCityKeyword() {
    cityKeywordController.clear();
  }

  @override
  void onClose() {
    keywordFocus.dispose();
    cityKeywordFocus.dispose();
    keywordController.dispose();
    cityKeywordController.dispose();
    _debounce?.cancel();
    _cityDebounce?.cancel();
    super.onClose();
  }

  // switch toggle
  void toggle() {
    isSelected.value = !isSelected.value;
  }

  void selectPresetValue(String value) {
    final doubleValue = double.tryParse(value);
    if (doubleValue == null) return; // invalid input

    final leftValue = double.tryParse(leftController.text);
    final rightValue = double.tryParse(rightController.text);

    if (isFocusedLeftField.value) {
      // When user is editing left side
      if (rightValue == null || doubleValue <= rightValue) {
        leftController.text = value;
      } else {
        // left > right, reset right side
        leftController.text = value;
        rightController.clear();
      }
      isFocusedRightField.value = false;
    } else {
      // When user is editing right side
      if (leftValue == null || doubleValue >= leftValue) {
        rightController.text = value;
      } else {
        // right < left, reset left side
        rightController.text = value;
        leftController.clear();
      }
      isFocusedLeftField.value = false;
    }

    selectedPreset.value = value;
  }

  /// Resets all declared variables to their default values.
  void resetAllFields() {
    homeIndex.value = 0;
    isFilterDrawerOpen.value = false;
    selectedIndex.value = 0;
    isSelected.value = false;
    selectedSubCategory.value = '';
    leftController.clear();
    rightController.clear();
    selectedPreset.value = '';
    isFocusedLeftField.value = false;
    isFocusedRightField.value = false;
    selectedDayFilter.value = '';
    selectedVendor.value = '';
    keywordFocus.unfocus();
    isKeywordFocused.value = false;
    keywordController.clear();
    keywordText.value = '';
    cityKeywordController.clear();
    cityKeywordText.value = '';
    cityKeywordFocus.unfocus();
    isCityKeywordFocused.value = false;
  }

  final List<String> daysItems = [
    'Tous',
    'Dernières 24h',
    '3 derniers jours',
    '7 derniers jours',
    '15 derniers jours',
  ];

  final List<String> vendeurList = [
    'Tous',
    '3.0 et plus',
    '3.5 et plus',
    '4.0 et plus',
    '4.5 et plus',
  ];

  Future<void> getFeaturedPosts() async {
    try {
      featuredPostsloading.value = true;
      fakeFeaturedPostsloading.value = false;

      final response = await postService.getFeaturedPosts();
      featuredPosts.clear();

      if (response == null) {
        errorMessageForFeatured.value = "Pas d'annonce trouvée";
      } else {
        featuredPosts.assignAll(response.content!);
        for (var post in featuredPosts) {
          if (post.userId != null &&
              !usersForfeaturedPosts.containsKey(post.userId)) {
            usersForfeaturedPosts[post.userId!] = await userService.getUser(
              userId: post.userId!,
            );
            usersForfeaturedPosts.refresh();
          }
        }
      }
    } catch (e) {
      logger.severe("❌ Unexpected error in getFeaturedPosts: $e");
      errorMessageForFeatured.value = "Erreur de chargement des annonces.";
    } finally {
      featuredPostsloading.value = false;
    }
  }

  Future<void> getTrendingPosts() async {

     try {
      trendingPostsloading.value = true;
      fakeTrendingPostsloading.value = false;
      
      final response = await postService.getTrendingPosts();
      trendingPosts.clear();

      if (response == null) {
        errorMessageForTrending.value = "Pas d'annonce trouvée";
      } else {
        trendingPosts.assignAll(response.content!);
        for (var post in trendingPosts) {
        if (post.userId != null &&
            !usersFortrendingPosts.containsKey(post.userId)) {
          usersFortrendingPosts[post.userId!] = await userService.getUser(
            userId: post.userId!,
          );
          usersFortrendingPosts.refresh();
        }
      }
      }
    } catch (e) {
      logger.severe("❌ Unexpected error in getFeaturedPosts: $e");
      errorMessageForTrending.value = "Erreur de chargement des annonces.";
    } finally {
      trendingPostsloading.value = false;
    }
  }

  Future<void> getSuggestedPosts() async {
    try {
      suggestedPostsloading.value = true;
      fakeSuggestedPostsloading.value = false;
      suggestedPosts.value = await postService.getSuggestedPosts(
        userId: profileController.userProfile.value!.id!,
      );
      print("it is not runnig ${profileController.userProfile.value!.id!}");

      for (var post in suggestedPosts) {
        if (post.userId != null &&
            !usersForSuggestedPosts.containsKey(post.userId)) {
          usersForSuggestedPosts[post.userId!] = await userService.getUser(
            userId: post.userId!,
          );
          usersForSuggestedPosts.refresh();
          print("========================================================");
          print("it is not runnig");
        }
      }
      suggestedPostsloading.value = false;
    } catch (e) {
      logger.severe(
        "❌ Unexpected error in homeController getSuggestedPosts: $e",
      );
    }
  }

  void setFakeLoadingsToTrue() {
    fakeFeaturedPostsloading.value = true;
    fakeTrendingPostsloading.value = true;
    fakeSuggestedPostsloading.value = true;
  }
}
