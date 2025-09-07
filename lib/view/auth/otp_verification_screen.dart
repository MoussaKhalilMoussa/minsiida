import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/common_widgets/applogo.dart';
import 'package:simple_nav_bar/common_widgets/bg_widget.dart';
import 'package:simple_nav_bar/common_widgets/ourbuttton.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/constants/strings.dart';
import 'package:simple_nav_bar/controllers/auth/auth_signup_controller.dart';
import 'package:simple_nav_bar/view/auth/utils_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class OtpVerificationScreen extends StatelessWidget {
  OtpVerificationScreen({super.key});

  var controller = Get.find<AuthSignupController>();

  @override
  Widget build(BuildContext context) {
    final response = Get.arguments;
    // Start timer
    controller.startTimer(300);
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  (context.screenHeight * 0.15).heightBox,
                  applogoWidget(),
                  10.heightBox,
                  "Join $appname".text
                      .fontWeight(FontWeight.bold)
                      .color(primaryColor)
                      .size(18)
                      .make(),
                  15.heightBox,
                  Obx(() {
                        final seconds = controller.remainingSeconds.value;
                        final minutes = (seconds ~/ 60).toString().padLeft(
                          2,
                          '0',
                        );
                        final secs = (seconds % 60).toString().padLeft(2, '0');

                        return Column(
                          children: [
                            SizedBox(
                              width: double.maxFinite,
                              child: Text(
                                response ?? "",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.playfairDisplay(
                                  color: blackColor2,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Form(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  otpBox(
                                    context: context,
                                    controller: controller.otp1Controller,
                                    callback: () {
                                      controller.getOtp();
                                    },
                                  ),
                                  otpBox(
                                    context: context,
                                    controller: controller.otp2Controller,
                                    callback: () {
                                      controller.getOtp();
                                    },
                                  ),
                                  otpBox(
                                    context: context,
                                    controller: controller.otp3Controller,
                                    callback: () {
                                      controller.getOtp();
                                    },
                                  ),
                                  otpBox(
                                    context: context,
                                    controller: controller.otp4Controller,
                                    callback: () {
                                      controller.getOtp();
                                    },
                                  ),
                                  otpBox(
                                    context: context,
                                    controller: controller.otp5Controller,
                                    callback: () {
                                      controller.getOtp();
                                    },
                                  ),
                                  otpBox(
                                    context: context,
                                    controller: controller.otp6Controller,
                                    callback: () {
                                      controller.getOtp();
                                    },
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 14.h),
                            Text(
                              "$minutes:$secs",

                              style: const TextStyle(
                                letterSpacing: 2,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 14.h),
                            ourButton(
                                  color:
                                      controller.activeButton.value
                                          ? primaryColor.withValues(alpha: 0.1)
                                          : primaryColor,

                                  onPressed:
                                      controller.isLoading.value
                                          ? null
                                          : () {
                                            if (!controller
                                                .activeButton
                                                .value) {
                                              controller.verifyOtp();
                                              controller.restFields();
                                            }
                                          },
                                  child:
                                      controller.isLoading.value
                                          ? CircularProgressIndicator(
                                            constraints: BoxConstraints.tight(
                                              Size.fromRadius(8.r),
                                            ),
                                            valueColor: AlwaysStoppedAnimation(
                                              whiteColor,
                                            ),
                                          )
                                          : Text(
                                            'Verify',
                                            style: GoogleFonts.playfairDisplay(
                                              color: whiteColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                ).box
                                .width(context.screenWidth - 50)
                                .height(context.screenWidth / 9)
                                .make(),

                            10.heightBox,
                          ],
                        );
                      }).box.white.rounded
                      .padding(const EdgeInsets.all(16))
                      .width(context.screenWidth - 70)
                      .shadowSm
                      .make(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
