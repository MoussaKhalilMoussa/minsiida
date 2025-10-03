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

  final postService = Get.put<PostServiceImpl>(PostServiceImpl());
  final userService = Get.put<UserServiceImpl>(UserServiceImpl());
  final profileController = Get.put<ProfileController>(ProfileController());

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
    rightController.text = value;
    leftController.clear();
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
      featuredPosts.value = await postService.getFeaturedPosts();
      //featuredPosts.assignAll(respons);
      // fetch all users for these posts
      for (var post in featuredPosts) {
        if (post.userId != null &&
            !usersForfeaturedPosts.containsKey(post.userId)) {
          usersForfeaturedPosts[post.userId!] = await userService.getUser(
            userId: post.userId!,
          );
          usersForfeaturedPosts.refresh();
        }
      }
      featuredPostsloading.value = false;
    } catch (e) {
      logger.severe("❌ Unexpected error in getFeaturedPosts: $e");
    }
  }

  Future<void> getTrendingPosts() async {
    try {
      trendingPostsloading.value = true;
      trendingPosts.value = await postService.getTrendingPosts();
      for (var post in trendingPosts) {
        if (post.userId != null &&
            !usersFortrendingPosts.containsKey(post.userId)) {
          usersFortrendingPosts[post.userId!] = await userService.getUser(
            userId: post.userId!,
          );
          usersFortrendingPosts.refresh();
        }
      }
      trendingPostsloading.value = false;
    } catch (e) {
      logger.severe("❌ Unexpected error in getTrendingPosts: $e");
    }
  }

  Future<void> getSuggestedPosts() async {
    try {
      suggestedPostsloading.value = true;
      suggestedPosts.value = await postService.getSuggestedPosts(
        userId: profileController.userProfile.value!.id!,
      );
      for (var post in suggestedPosts) {
        if (post.userId != null &&
            !usersForSuggestedPosts.containsKey(post.userId)) {
          usersForSuggestedPosts[post.userId!] = await userService.getUser(
            userId: post.userId!,
          );
          usersForSuggestedPosts.refresh();
        }
      }
      suggestedPostsloading.value = false;
    } catch (e) {
      logger.severe("❌ Unexpected error in homeController getSuggestedPosts: $e");
    }
  }
}
