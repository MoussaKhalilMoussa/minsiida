import 'package:get/get.dart';

class DeliveryController extends GetxController {

  var selectedMethod = ''.obs;

  void selectMethod(String method) {
    selectedMethod.value = method;
  }
}
