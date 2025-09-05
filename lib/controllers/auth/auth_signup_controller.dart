import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/services/auth_service/auth_service_imple.dart';
import 'package:simple_nav_bar/view/auth/login_screen.dart';
import 'package:simple_nav_bar/view/auth/otp_verification_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthSignupController extends GetxController {
  var isLoading = false.obs;
  RxBool isCheckPrivacyTermAndConditions = false.obs;
  RxBool activeButton = true.obs;

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final authService = Get.put<AuthServiceImple>(AuthServiceImple());

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

  // Controllers for OTP fields
  final otp1Controller = TextEditingController();
  final otp2Controller = TextEditingController();
  final otp3Controller = TextEditingController();
  final otp4Controller = TextEditingController();
  final otp5Controller = TextEditingController();
  final otp6Controller = TextEditingController();

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

  void register() async {
    //await Future.delayed(Duration(seconds: 2));
    try {
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

      isLoading.value = true;
      var response = await authService.registerUser(
        context: Get.context!,
        name: name,
        userName: userName,
        email: email,
        password: password,
      );

      Get.off(() => OtpVerificationScreen(), arguments: response);
    } catch (e) {
      print("❌ AuthController error: $e");
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  // Function to collect OTP
  String getOtp() {
    var otpCode =
        otp1Controller.text +
        otp2Controller.text +
        otp3Controller.text +
        otp4Controller.text +
        otp5Controller.text +
        otp6Controller.text;
    if (otpCode.length == 6) {
      activeButton.value = false;
    } else {
      activeButton.value = true;
    }
    return otpCode;
  }

  void verifyOtp() async {
    try {
      final otpCode = getOtp();
      isLoading.value = true;
      var response = await authService.otpVerification(
        otpCode: otpCode,
        context: Get.context!,
      );
      Get.snackbar(
        icon: Icon(Ionicons.checkbox, color: greenColor),
        maxWidth: Get.context!.screenWidth - 60,
        backgroundGradient: LinearGradient(
          colors: [primaryColor, primaryColor],
        ),
        colorText: blackColor2,
        duration: Duration(seconds: 3),
        "Verification Success",
        response,
        snackPosition: SnackPosition.TOP,
      );

      Get.off(() => LoginScreen());
    } catch (e) {
      print("❌ AuthController error: $e");
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  // Timer variables
  var remainingSeconds = 60.obs; // default 60 seconds
  Timer? _timer;

  // Start countdown
  void startTimer([int seconds = 60]) {
    remainingSeconds.value = seconds;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    retypePasswordController.dispose();
    otp1Controller.dispose();
    otp2Controller.dispose();
    otp3Controller.dispose();
    otp4Controller.dispose();
    otp5Controller.dispose();
    otp6Controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void restFields() {
    nameController.clear();
    userNameController.clear();
    emailController.clear();
    passwordController.clear();
    retypePasswordController.clear();
    otp1Controller.clear();
    otp2Controller.clear();
    otp3Controller.clear();
    otp4Controller.clear();
    otp5Controller.clear();
    otp6Controller.clear();
    isCheckPrivacyTermAndConditions.value = false;
  }
}
