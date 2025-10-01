import 'package:get/get.dart';
import 'package:simple_nav_bar/constants/lists.dart';
import 'package:simple_nav_bar/services/category_service/category_service_impl.dart';
import 'package:simple_nav_bar/view/categories/models/category.dart';

class CategoryContorller extends GetxController {
  final categoryService = CategoryServiceImpl();

  RxInt selectedCategoryIndex = (-1).obs;
  RxBool showCategoryError = false.obs;
  var selectedSubcategory = ''.obs;
  var isSelected = false.obs;
  late List<Category> categories;

  @override
  void onInit() {
    super.onInit();
    //getCategories();
  }

  getCategories() async {
    try {
      List<Category> categoriesData =
          (await categoryService.getAllCategories()).cast<Category>();
      for (var cat in categoriesData) {
        cat.icon = iconMap[cat.name] ?? "❓";
      }
      categories = categoriesData;
    } catch (e) {
      print("❌ Failed to load categories: $e");
    }
  }

  clear() {
    selectedCategoryIndex.value = -1;
    selectedSubcategory.value = '';
    isSelected.value = false;
    showCategoryError.value = false;
  }
}
