import 'package:get/get.dart';
import 'package:simple_nav_bar/services/user_service/user_service_impl.dart';
import 'package:simple_nav_bar/utiles/logger.dart';
import 'package:simple_nav_bar/view/profile/model/user_profile.dart';

class PosttDetailsController extends GetxController {
  final userService = Get.put<UserServiceImpl>(UserServiceImpl());

  late List products;
  late int selectedIndex;
  final RxInt selectedImageIndex = 0.obs;
  var isShippingSelected = false.obs;
  RxBool isUserLoading = false.obs;

  var postUser = Rxn<UserProfile?>();

  /* @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    products = args[0];
    final Post post = Get.arguments;

    selectedIndex = args[1];
  } */

  void getUser({required int userId}) async {
    try {
      isUserLoading.value = true;
      final user = await userService.getUser(userId: userId);
      postUser.value = user;
    } catch (e) {
      logger.severe("Unexpected error happened in getUser postController");
    } finally {
      isUserLoading.value = false;
    }
  }

  get selectedProduct => products[selectedIndex];
}
