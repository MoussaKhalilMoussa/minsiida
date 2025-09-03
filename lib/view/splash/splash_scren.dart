import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
  bool fakeUser = false;
  void changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!fakeUser && mounted) {
        Get.to(() => HomeScreen());
      } else {
        Get.to(() => const LoginScreen());
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
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(icSplashBg, width: 300),
            ),
            SizedBox(height: 20.h),
            Container(
              height: 77.h,
              width: 77.w,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(minsiidaLogo),
            ),
            Text(
              appname,
              style: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: whiteColor,
              ),
            ),
            SizedBox(height: 5.h),
            Text(appversion, style: TextStyle(color: whiteColor)),
            const Spacer(),
            Text(
              credits,
              style: TextStyle(color: whiteColor, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
