import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/constants/strings.dart';
import 'package:simple_nav_bar/services/auth_service/auth_service_imple.dart';
import 'package:simple_nav_bar/view/home/screen/home.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthLoginController extends GetxController {
  var isLoading = false.obs;
  // textControllers
  final authService = Get.put<AuthServiceImple>(AuthServiceImple());
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final storage = GetStorage(); // local storage for token

  Future<void> loginMethod({context}) async {
    try {
      isLoading.value = true;

      final token = await authService.userLogin(
        userName: emailController.text.trim(),
        password: passwordController.text.trim(),
        context: context,
      );

      if (token.isNotEmpty) {
        await storage.write(authToken, token);
        print(" Token saved: $token");

        // Navigate to home/dashboard
        Get.snackbar(
          maxWidth: Get.context!.screenWidth - 60,
          backgroundGradient: LinearGradient(
            colors: [primaryColor, primaryColor],
          ),
          colorText: blackColor2,
          duration: Duration(seconds: 3),
          "Login Success",
          loggedin,
          snackPosition: SnackPosition.TOP,
        );
        Get.off(() => HomeScreen());
      } else {
        // ⚠️ Show error
        Get.snackbar(
          maxWidth: Get.context!.screenWidth - 60,
          "Login Failed",
          "Invalid username or password",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print("❌ AuthController error: $e");
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
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
