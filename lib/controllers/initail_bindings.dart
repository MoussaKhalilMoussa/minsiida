import 'package:get/get.dart';
import 'package:simple_nav_bar/controllers/auth/auth_login_controller.dart';
import 'package:simple_nav_bar/controllers/auth/auth_signup_controller.dart';
import 'package:simple_nav_bar/controllers/filter_controller/filter_controller.dart';
import 'package:simple_nav_bar/controllers/profile_controllers/avis_et_evaluation_controller/avis_et_evaluation_controller.dart';
import 'package:simple_nav_bar/controllers/profile_controllers/notifications_controller.dart/notifications_controller.dart';
import 'package:simple_nav_bar/controllers/profile_controllers/parametres_controller/parametres_controller.dart';
import '../controllers/location_controller/location_controller.dart';
import '../controllers/details_page_controller/details_page_controller.dart';
import 'specifications_controller/specification_controller.dart';
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
    Get.put<AvisEtEvaluationController>(AvisEtEvaluationController());
    Get.put<ParametresController>(ParametresController());
    Get.put<FilterController>(FilterController());
    Get.put<AuthLoginController>(AuthLoginController());
    Get.put<AuthSignupController>(AuthSignupController());
  }
}
