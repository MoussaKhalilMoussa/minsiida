import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsPageController extends GetxController {
  TextEditingController get titleController => _titleController;
  TextEditingController get priceController => _priceController;
  TextEditingController get descController => _descController;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  final RxBool titleTouched = false.obs;
  final RxBool priceTouched = false.obs;
  final RxBool descTouched = false.obs;

  final RxBool showDetailsError = false.obs;

  final RxBool showTitleError = false.obs;
  final RxBool showPriceError = false.obs;
  final RxBool showDescriptionError = false.obs;

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    descController.dispose();
    super.dispose();
  }
}
