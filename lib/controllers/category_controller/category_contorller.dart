import 'package:get/get.dart';
import 'package:simple_nav_bar/constants/lists.dart';
import 'package:simple_nav_bar/services/category_service/category_service_impl.dart';
import 'package:simple_nav_bar/view/categories/models/category.dart';

class CategoryContorller extends GetxController {
  final categoryService = CategoryServiceImpl();

  RxInt selectedCategoryIndex = (-1).obs;

  RxBool showCategoryError = false.obs;
  var selectedCategoryName = "".obs;
  var selectedCategoryId = 0.obs;
  var selectedSubcategory = ''.obs;
  var isSelected = false.obs;

  // to store addPost category for category selection
  late List<Category> categories;

// to store home page category horizontal slider value
  var categories1 = <Category>[].obs;

// store adds of the same category

// for addPost category selection
  getCategories() async {
    try {
      List<Category> categoriesData =
          (await categoryService.getAllCategories()).cast<Category>();
      for (var cat in categoriesData) {
        cat.icon = stringIconMap[cat.name] ?? "❓";
      }
      categories = categoriesData;
    } catch (e) {
      print("❌ Failed to load categories: $e");
    }
  }

// for the home page category horizontal slider
  getCategories1() async {
    try {
      final categoriesData1 =
          (await categoryService.getAllCategories()).cast<Category>();
      Category categoryPourTout = Category(name: "Tous", icon: "Tous");

      categories1.clear(); // reset the list first
      categories1.add(categoryPourTout); // add "Tous" manually
      categories1.addAll(categoriesData1);
    } catch (e) {
      print("❌ Failed to load categories1: $e");
    }
  }

/*  getCategoriesByName({}){

} */


  clear() {
    selectedCategoryIndex.value = -1;
    selectedSubcategory.value = '';
    isSelected.value = false;
    showCategoryError.value = false;
  }
}
