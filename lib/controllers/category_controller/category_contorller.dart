import 'package:get/get.dart';

class CategoryContorller extends GetxController {
  RxInt selectedCategoryIndex = (-1).obs;
  RxBool showCategoryError = false.obs;
  var selectedSubcategory = ''.obs;
  var isSelected = false.obs;
  
}
