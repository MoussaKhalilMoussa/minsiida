import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt homeIndex = 0.obs;
  var isFilterDrawerOpen = false.obs;
  var selectedIndex = 0.obs;

  var isSelected = false.obs;
  var selectedSubCategory = ''.obs;

  final leftController = TextEditingController();
  final rightController = TextEditingController();

  var selectedPreset = ''.obs; // Tracks which preset is selected

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
}
