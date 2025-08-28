import 'package:get/get.dart';

class NotificationsController extends GetxController {
  var isTousTabSelected = true.obs;
  var isNonLusTabSelected = false.obs;
  var isMessagesTabSelected = false.obs;
  var isOffresTabSelected = false.obs;
  var isNotificationRead = false.obs;
  var notificationText = "7 Notifications".obs;
  var isRead = false.obs;

  void isReadFunc() {
    isRead.value = !isRead.value;
    update();
  }

  void isTousTabSelectedFunc() {
    isTousTabSelected.value = true;
    notificationText.value = "7 Notifications";
    isNonLusTabSelected.value = false;
    isMessagesTabSelected.value = false;
    isOffresTabSelected.value = false;
    update();
  }

  void isNonLusTabSelectedFunc() {
    isTousTabSelected.value = false;
    isNonLusTabSelected.value = true;
    notificationText.value = "3 Non lus";
    isMessagesTabSelected.value = false;
    isOffresTabSelected.value = false;
    update();
  }

  void isMessagesTabSelectedFunc() {
    isTousTabSelected.value = false;
    isNonLusTabSelected.value = false;
    isMessagesTabSelected.value = true;
    notificationText.value = "1 Messages";
    isOffresTabSelected.value = false;
    update();
  }

  void isOffresTabSelectedFunc() {
    isTousTabSelected.value = false;
    isNonLusTabSelected.value = false;
    isMessagesTabSelected.value = false;
    isOffresTabSelected.value = true;
    notificationText.value = "1 Offres";
    update();
  }
}
