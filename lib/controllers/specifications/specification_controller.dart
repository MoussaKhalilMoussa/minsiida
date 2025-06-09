import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SpecificationController extends GetxController {
  final TextEditingController _modelController = TextEditingController();
  TextEditingController get modelController => _modelController;
  final modeles = <String>[..._iPhoneModels].obs;
  final filteredModels = <String>[..._iPhoneModels].obs;

  final Rx<String?> selectedModel = Rx<String?>(null);
  final RxBool showModelError = false.obs;

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

  void resetSelectedModel() {
    filteredModels.value = <String>[..._iPhoneModels];
  }

  @override
  void dispose() {
    modelController.dispose();
    super.dispose();
  }

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
