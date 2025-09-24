import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:simple_nav_bar/services/auth_service/auth_service_imple.dart';
import 'package:simple_nav_bar/view/profile/model/user_profile.dart';

class ProfileController extends GetxController {
  final authService = AuthServiceImple();

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var userNameController = TextEditingController();
  //TextEditingController phoneController = TextEditingController();

  var userProfile = Rxn<UserProfile>();
  @override
  void onInit() {
    super.onInit();
    loadProfile(); // call it right away
  }

  Future<void> loadProfile() async {
    try {
      final profile = await authService.profile();
      if (profile != null) {
        userProfile.value = profile;
      }
    } catch (e) {
      print("❌ Failed to load profile: $e");
    }
  }
}
