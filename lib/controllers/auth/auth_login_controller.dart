import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/constants/strings.dart';
import 'package:simple_nav_bar/services/auth_service/auth_service_imple.dart';
import 'package:simple_nav_bar/utiles/token_utils.dart';
import 'package:simple_nav_bar/view/home/screen/home.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthLoginController extends GetxController {
  var isLoading = false.obs;
  // textControllers
  final authService = Get.put<AuthServiceImple>(AuthServiceImple());
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;
  
  var email = "";

  Future<void> loginMethod({context}) async {
    try {
      isLoading.value = true;
     
      final token = await authService.userLogin(
        userName: userNameController.text.trim(),
        password: passwordController.text.trim(),
        context: context,
      );

      if (token.isNotEmpty) {
        //await storage.write(authToken, token);
        TokenUtils.saveToken(token);
        print(" Token saved: $token");

        // Navigate to home/dashboard
        Get.snackbar(
          maxWidth: Get.context!.screenWidth - 40,
          backgroundGradient: LinearGradient(
            colors: [greenColor, greenColor.withBrightness],
          ),
          colorText: blackColor2,
          duration: Duration(seconds: 3),
          "Login Success",
          loggedin,
          snackPosition: SnackPosition.TOP,
        );
        Get.off(() => HomeScreen());
      }
    } catch (e) {
      print("❌ AuthController error: $e");
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetByEmailMethod({context}) async {
    try {
      var response = await authService.resetByEmail(
        email: emailController.text,
        context: context,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  // vlidate email
  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Veuillez saisir une adresse e-mail valide";
    }
    return null;
  }

  @override
  void onClose() {
    userNameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void clearFields() {
    userNameController.clear();
    passwordController.clear();
  }

  //signup method

  // storing data method
  storeUserData({name, password, email}) async {
    /* 
    DocumentReference store = firestore
        .collection(usersCollection)
        .doc(currentUser!.uid);
    store.set({
      'name': name,
      'password': password,
      'email': email,
      'imageUrl': '',
      'id': currentUser!.uid,
      'cart_count': "00",
      'whishlist_count': "00",
      'order_count': "00",
    }); */
  }

  //signout method
  signoutMethod(context) async {
    /* try {
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    } */
  }
}
