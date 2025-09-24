import 'package:get/get.dart';

class AvisEtEvaluationController extends GetxController {
  var isTousTabSelected = true.obs;
  var isPositifs = false.obs;
  var isNeutres = false.obs;
  var isNegatifs = false.obs;
  var isRead = false.obs;

  void isTousTabSelectedFunc() {
    isTousTabSelected.value = true;
    isPositifs.value = false;
    isNeutres.value = false;
    isNegatifs.value = false;
    update();
  }

  void isPositifsFunc() {
    isTousTabSelected.value = false;
    isPositifs.value = true;
    isNeutres.value = false;
    isNegatifs.value = false;
    update();
  }

  void isNeutresFunc() {
    isTousTabSelected.value = false;
    isPositifs.value = false;
    isNeutres.value = true;
    isNegatifs.value = false;
    update();
  }

  void isNegatifsFunc() {
    isTousTabSelected.value = false;
    isPositifs.value = false;
    isNeutres.value = false;
    isNegatifs.value = true;
    update();
  }
}
