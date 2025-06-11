import 'package:get/get.dart';

class DeliveryController extends GetxController {
  var selectedMethod = ''.obs;
  var showDeliveryError = false.obs;

  void selectMethod(String method) {
    selectedMethod.value = method;
  }

  void resetFields() {
    selectedMethod.value = "";
  }
}
