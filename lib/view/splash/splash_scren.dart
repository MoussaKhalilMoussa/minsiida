import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/constants/images.dart';
import 'package:simple_nav_bar/constants/strings.dart';
import 'package:simple_nav_bar/view/auth/login_screen.dart';
import 'package:simple_nav_bar/view/home/screen/home.dart';

class SplashScren extends StatefulWidget {
  const SplashScren({super.key});

  @override
  State<SplashScren> createState() => _SplashScrenState();
}

class _SplashScrenState extends State<SplashScren> {
  bool fakeUser = true;
  void changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!fakeUser && mounted) {
        Get.to(() => HomeScreen());
      } else {
        Get.to(() => LoginScreen());
      }
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                minsiidaSplash,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20.h),
            Column(
              children: [
                const Spacer(),
                CircularProgressIndicator(color: primaryColor),
                SizedBox(height: 200.h),
                Text(
                  credits,
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
