import 'package:get/get.dart';

class ParametresController extends GetxController {
  var isToutSelected = true.obs;
  var isNotificationsSelected = false.obs;
  var isConfidentialiteSelected = false.obs;
  var isSecuritySelected = false.obs;
  var isComptesLinkedSelected = false.obs;

  void isToutSelectedFunc() {
    isToutSelected.value = true;
    isNotificationsSelected.value = false;
    isConfidentialiteSelected.value = false;
    isSecuritySelected.value = false;
    isComptesLinkedSelected.value = false;
    update();
  }

  void isNotificationsSelectedFunc() {
    isToutSelected.value = false;
    isNotificationsSelected.value = true;
    isConfidentialiteSelected.value = false;
    isSecuritySelected.value = false;
    isComptesLinkedSelected.value = false;
    update();
  }

  void isConfidentialiteSelectedFunc() {
    isToutSelected.value = false;
    isNotificationsSelected.value = false;
    isConfidentialiteSelected.value = true;
    isSecuritySelected.value = false;
    isComptesLinkedSelected.value = false;
    update();
  }

  void isSecuritySelectedFunc() {
    isToutSelected.value = false;
    isNotificationsSelected.value = false;
    isConfidentialiteSelected.value = false;
    isSecuritySelected.value = true;
    isComptesLinkedSelected.value = false;
    update();
  }

  void isComptesLinkedSelectedFunc() {
    isToutSelected.value = false;
    isNotificationsSelected.value = false;
    isConfidentialiteSelected.value = false;
    isSecuritySelected.value = false;
    isComptesLinkedSelected.value = true;
    update();
  }
}
