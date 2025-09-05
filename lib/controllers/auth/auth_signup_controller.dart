import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthSignupController extends GetxController {
  var isLoading = false.obs;
  RxBool isCheckPrivacyTermAndConditions = false.obs;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordRetypeController =
      TextEditingController();

  TextEditingController get nameController => _nameController;
  TextEditingController get userNameController => _userNameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get retypePasswordController =>
      _passwordRetypeController;

  var name = "";
  var userName = "";
  var email = "";
  var password = "";
  var retypePassword = "";

  final RxBool nameTouched = false.obs;
  final RxBool userNameTouched = false.obs;
  final RxBool emailTouched = false.obs;
  final RxBool passwordTouched = false.obs;
  final RxBool retypePasswordTouched = false.obs;

  final RxBool showNameError = false.obs;
  final RxBool showUserNameError = false.obs;
  final RxBool showEmailError = false.obs;
  final RxBool showPasswordError = false.obs;
  final RxBool showRetypePasswordError = false.obs;

  Future<void> signupMethod({email, password, context}) async {}

  String? validateName(String value) {
    if (value.length < 8) {
      return "The name must be at least 6 charaecters.";
    }
    return null;
  }

  String? validateUserName(String value) {
    if (value.length < 6) {
      return "The username must be at least 6 charaecters.";
    }
    return null;
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide valid Email";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  String? validateRetypePassword(String value) {
    if (value.isEmpty) {
      return "Please retype your password";
    }
    if (value != password) {
      return "Passwords do not match";
    }
    return null;
  }

  void isCheckedPrivacyTermAndConditionsFunc(bool? value) {
    if (value != null) {
      isCheckPrivacyTermAndConditions.value = value;
    }
  }

  void checkLogin() async {
    await Future.delayed(Duration(seconds: 2));
    final isValid = loginFormKey.currentState!.validate();

    if (!isCheckPrivacyTermAndConditions.value) {
      Get.snackbar(
        maxWidth: Get.context!.screenWidth - 60,
        duration: Duration(seconds: 3),
        "Missing Field",
        "Please Accepte the terms and conditions",
        snackPosition: SnackPosition.BOTTOM,
        backgroundGradient: LinearGradient(
          colors: [Vx.yellow400, Vx.yellow400.withBrightness],
        ),
      );
      return;
    }

    if (!isValid) {
      return;
    }
    loginFormKey.currentState!.save();
    print(name);
    print(userName);
    print(email);
    print(password);
    print(retypePassword);
  }

  @override
  void dispose() {
    nameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    retypePasswordController.dispose();
    super.dispose();
  }

  void restFields() {
    nameController.clear();
    userNameController.clear();
    emailController.clear();
    passwordController.clear();
    retypePasswordController.clear();

    nameTouched.value = false;
    userNameTouched.value = false;
    emailTouched.value = false;
    passwordTouched.value = false;
    retypePasswordTouched.value = false;

    showNameError.value = false;
    showUserNameError.value = false;
    showEmailError.value = false;
    showPasswordError.value = false;
    showRetypePasswordError.value = false;
  }
}
