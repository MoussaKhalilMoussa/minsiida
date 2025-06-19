import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  late List products;
  late int selectedIndex;
  final RxInt selectedImageIndex = 0.obs;
  var isShippingSelected = false.obs;



  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    products = args[0];
    selectedIndex = args[1];
  }

  get selectedProduct => products[selectedIndex];
}
