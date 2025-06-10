import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SpecificationController extends GetxController {
  final TextEditingController _modelController = TextEditingController();
  TextEditingController get modelController => _modelController;
  final modeles = <String>[..._iPhoneModels].obs;
  final storages = <String>[..._storageOptions].obs;
  final colors = <String>[..._colorsOptions].obs;
  final bateryStates = <String>[..._bateryStateOptions].obs;
  final guarentees = <String>[..._guaranteeOptions].obs;
  final conditions = <String>[..._conditionOptions].obs;

  final filteredModels = <String>[..._iPhoneModels].obs;
  final filteredStorage = <String>[..._storageOptions].obs;
  final filteredColors = <String>[..._colorsOptions].obs;
  final filteredBateryStates = <String>[..._colorsOptions].obs;
  final filteredGuarantees = <String>[..._guaranteeOptions].obs;
  final filteredConditions = <String>[..._conditionOptions].obs;

  final Rx<String?> selectedModel = Rx<String?>(null);
  final Rx<String?> selectedStorage = Rx<String?>(null);
  final Rx<String?> selectedColor = Rx<String?>(null);
  final Rx<String?> selectedBateryState = Rx<String?>(null);
  final Rx<String?> selectedGuarantee = Rx<String?>(null);
  final Rx<String?> selectedCondition = Rx<String?>(null);

  final RxBool showModelError = false.obs;
  final RxBool showStorageError = false.obs;
  final RxBool showColorError = false.obs;
  final RxBool showBateryStateError = false.obs;
  final RxBool showGuaranteeError = false.obs;
  final RxBool showConditionError = false.obs;

  void filterModels(String query) {
    final results = _iPhoneModels;
    if (query.isEmpty) {
      filteredModels.assignAll(results);
    } else {
      filteredModels.assignAll(
        _iPhoneModels
            .where((m) => m.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    }
  }

  void filterStorage(String query) {
    final results = _storageOptions;
    if (query.isEmpty) {
      filteredStorage.assignAll(results);
    } else {
      filteredStorage.assignAll(
        _storageOptions
            .where((m) => m.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    }
  }

  void filterColor(String query) {
    final results = _colorsOptions;
    if (query.isEmpty) {
      filteredColors.assignAll(results);
    } else {
      filteredColors.assignAll(
        _colorsOptions
            .where((m) => m.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    }
  }

  void filterState(String query) {
    final results = _bateryStateOptions;
    if (query.isEmpty) {
      filteredBateryStates.assignAll(results);
    } else {
      filteredBateryStates.assignAll(
        _bateryStateOptions
            .where((m) => m.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    }
  }

  void filterGuarantee(String query) {
    final results = _guaranteeOptions;
    if (query.isEmpty) {
      filteredGuarantees.assignAll(results);
    } else {
      filteredGuarantees.assignAll(
        _guaranteeOptions
            .where((m) => m.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    }
  }

  void filterCondition(String query) {
    final results = _conditionOptions;
    if (query.isEmpty) {
      filteredConditions.assignAll(results);
    } else {
      filteredConditions.assignAll(
        _conditionOptions
            .where((m) => m.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    }
  }

  void resetSelectedModel() {
    filteredModels.value = <String>[..._iPhoneModels];
    filteredStorage.value = <String>[..._storageOptions];
    filteredColors.value = <String>[..._colorsOptions];
    filteredBateryStates.value = <String>[..._bateryStateOptions];
    filteredGuarantees.value = <String>[..._guaranteeOptions];
    filteredConditions.value = <String>[..._conditionOptions];
  }

  @override
  void dispose() {
    modelController.dispose();
    super.dispose();
  }

  static final List<String> _conditionOptions = [
    "Neuf",
    "Comme Neuf",
    "Bon État",
    "État Moyen",
    "Pour pieces",
  ];

  static final List<String> _guaranteeOptions = [
    "Sous garantie",
    "Sans garantie",
  ];

  static final List<String> _bateryStateOptions = [
    "90-100%",
    "80-98%",
    "70-79%",
    "Moins de 70%",
  ];

  static final List<String> _colorsOptions = [
    "Rouge",
    "Bleu",
    "Vert",
    "Jaune",
    "Orange",
    "Rose",
    "Violet",
    "Marron",
    "Noir",
  ];

  static final List<String> _storageOptions = [
    "32 Go",
    "64 Go",
    "128 Go",
    "256 Go",
    "512 Go",
    "1 To",
    "2 To",
    "4 To",
    "8 To",
  ];

  static final List<String> _iPhoneModels = [
    'iPhone X',
    'iPhone XR',
    'iPhone XS',
    'iPhone XS Max',
    'iPhone 11',
    'iPhone 11 Pro',
    'iPhone 11 Pro Max',
    'iPhone SE (2nd generation)', // 2020
    'iPhone 12',
    'iPhone 12 Mini',
    'iPhone 12 Pro',
    'iPhone 12 Pro Max',
    'iPhone 13',
    'iPhone 13 Mini',
    'iPhone 13 Pro',
    'iPhone 13 Pro Max',
    'iPhone SE (3rd generation)', // 2022
    'iPhone 14',
    'iPhone 14 Plus',
    'iPhone 14 Pro',
    'iPhone 14 Pro Max',
    'iPhone 15',
    'iPhone 15 Plus',
    'iPhone 15 Pro',
    'iPhone 15 Pro Max',
    'iPhone SE (4th generation)', // expected around 2025
    'iPhone 16', // Expected fall 2025
    'iPhone 16 Plus',
    'iPhone 16 Pro',
    'iPhone 16 Pro Max',
  ];
}
