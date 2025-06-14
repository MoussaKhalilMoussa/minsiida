import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt homeIndex = 0.obs;
  var isFilterDrawerOpen = false.obs;
  var selectedIndex = 0.obs;

  var isSelected = true.obs;

  void toggle() {
    isSelected.value = !isSelected.value;
  }

  //RxInt categoryIndex = 1.obs;
}
