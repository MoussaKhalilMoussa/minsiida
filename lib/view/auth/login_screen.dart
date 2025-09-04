import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/common_widgets/applogo.dart';
import 'package:simple_nav_bar/common_widgets/bg_widget.dart';
import 'package:simple_nav_bar/common_widgets/custom_textfield.dart';
import 'package:simple_nav_bar/common_widgets/ourbuttton.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/constants/lists.dart';
import 'package:simple_nav_bar/constants/strings.dart';
import 'package:simple_nav_bar/controllers/auth/auth_login_controller.dart';
import 'package:simple_nav_bar/view/auth/sign_up_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<AuthLoginController>();
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (MediaQuery.sizeOf(Get.context!).height * 0.15).heightBox,
              applogoWidget(),
              10.heightBox,
              "Log in to $appname".text
                  .fontWeight(FontWeight.bold)
                  .color(primaryColor)
                  .size(18)
                  .make(),
              15.heightBox,
              Obx(
                () =>
                    Column(
                          children: [
                            customeTextField(
                              title: email,
                              hint: emailHint,
                              isPass: false,
                              controller: controller.emailController,
                            ),
                            customeTextField(
                              title: password,
                              hint: passwordHint,
                              isPass: true,
                              controller: controller.passwordController,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child:
                                    forgetPass.text
                                        .color(
                                          blackColor2.withValues(alpha: 0.8),
                                        )
                                        .make(),
                              ),
                            ),
                            5.heightBox,
                            ourButton(
                                  color: primaryColor,

                                  onPressed:
                                      controller.isLoading.value
                                          ? null
                                          : () async {
                                            await controller.loginMethod(
                                              context: context,
                                            );
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
                                            login,
                                            style: GoogleFonts.playfairDisplay(
                                              color: whiteColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                ).box
                                .width(context.screenWidth - 50)
                                .height(context.screenWidth / 9)
                                .make(),
                            5.heightBox,
                            createNewAccount.text.color(greyColo1).make(),
                            5.heightBox,
                            ourButton(
                                  onPressed: () {
                                    Get.to(() => const SignupScreen());
                                  },
                                  color: greyColo1.withValues(alpha: 0.1),

                                  child: Text(
                                    signup,
                                    style: GoogleFonts.playfairDisplay(
                                      color: greyColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ).box
                                .width(context.screenWidth - 50)
                                .height(context.screenWidth / 9)
                                .make(),
                            10.heightBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                3,
                                (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundColor: lightGrey,
                                    radius: 25,
                                    child: Image.asset(
                                      socialIconList[index],
                                      width: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ).box.white.rounded
                        .padding(const EdgeInsets.all(16))
                        .width(context.screenWidth - 70)
                        .shadowSm
                        .make(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
