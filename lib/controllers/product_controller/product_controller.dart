import 'package:get/get.dart';
import 'package:simple_nav_bar/constants/lists.dart';

class ProductController extends GetxController {
  final allProducts = List.generate(50, (i) => "Product ${i + 1}");

  final products = productsList;

  final visibleCount = 24.obs;

  final isLoadingMore = false.obs;

  final isFavorite = false.obs;


  void showMore() async {
    isLoadingMore.value = true;
    await Future.delayed(Duration(seconds: 2));
    if (visibleCount.value < products.length) {
      visibleCount.value += 12;
    }
    isLoadingMore.value = false;
  }

  bool get isAllVisible => visibleCount.value >= products.length;
}
