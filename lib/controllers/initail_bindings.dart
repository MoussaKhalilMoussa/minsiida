import 'package:get/get.dart';
import 'package:simple_nav_bar/controllers/notifications_controller.dart/notifications_controller.dart';
import '../controllers/location_controller/location_controller.dart';
import '../controllers/details_page_controller/details_page_controller.dart';
import '../controllers/specifications/specification_controller.dart';
import '../controllers/delivery_controller/delivery_controller.dart';
import '../controllers/category_controller/category_contorller.dart';
import '../controllers/home_controller/home_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LocationController>(LocationController());
    Get.put<DetailsPageController>(DetailsPageController());
    Get.put<SpecificationController>(SpecificationController());
    Get.put<DeliveryController>(DeliveryController());
    Get.put<CategoryContorller>(CategoryContorller());
    Get.put<HomeController>(HomeController());
    Get.put<NotificationsController>(NotificationsController());
  }
}
