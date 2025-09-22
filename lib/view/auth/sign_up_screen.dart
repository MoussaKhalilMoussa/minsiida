import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/common_widgets/applogo.dart';
import 'package:simple_nav_bar/common_widgets/bg_widget.dart';
import 'package:simple_nav_bar/common_widgets/custom_textfield.dart';
import 'package:simple_nav_bar/common_widgets/ourbuttton.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/constants/strings.dart';
import 'package:simple_nav_bar/controllers/auth/auth_signup_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var controller = Get.find<AuthSignupController>();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  (context.screenHeight * 0.01).heightBox,
                  applogoWidget(),
                  10.heightBox,
                  "Join $appname".text
                      .fontWeight(FontWeight.bold)
                      .color(primaryColor)
                      .size(18)
                      .make(),
                  15.heightBox,
                  Obx(
                        () => Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: controller.loginFormKey,
                          child: Column(
                            children: [
                              customeTextField(
                                title: name,
                                hint: nameHint,
                                controller: controller.nameController,
                                isPass: false,
                                validator: (value) {
                                  return controller.validateName(value!);
                                },
                                onSaved: (value) {
                                  controller.name = value!;
                                },
                              ),
                              customeTextField(
                                title: userName,
                                hint: userNameHint,
                                controller: controller.userNameController,
                                validator: (value) {
                                  return controller.validateUserName(value!);
                                },
                                onSaved: (value) {
                                  controller.userName = value!;
                                },
                                isPass: false,
                              ),
                              customeTextField(
                                title: email,
                                hint: emailHint,
                                controller: controller.emailController,
                                validator: (value) {
                                  return controller.validateEmail(value!);
                                },
                                onSaved: (value) {
                                  controller.email = value!;
                                },
                                isPass: false,
                              ),
                              customeTextField(
                                title: password,
                                hint: passwordHint,
                                controller: controller.passwordController,
                                isPass: true,
                                onChanged: (value) {
                                  controller.password = value;
                                  controller.loginFormKey.currentState
                                      ?.validate();
                                },
                                validator: (value) {
                                  return controller.validatePassword(value!);
                                },
                                onSaved: (value) {
                                  controller.password = value!;
                                },
                              ),
                              customeTextField(
                                title: retypePassword,
                                hint: passwordHint,
                                controller: controller.retypePasswordController,
                                isPass: true,
                                onChanged: (value) {
                                  controller.retypePassword = value;
                                  controller.loginFormKey.currentState
                                      ?.validate();
                                },
                                validator: (value) {
                                  return controller.validateRetypePassword(
                                    value!,
                                  );
                                },
                                onSaved: (value) {
                                  controller.retypePassword = value!;
                                },
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: TextButton(
                                  onPressed: () {},
                                  child:
                                      forgetPass.text
                                          .color(blackColor2)
                                          .fontWeight(FontWeight.bold)
                                          .make(),
                                ),
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    //checkColor: primaryColor,
                                    activeColor: primaryColor,
                                    value:
                                        controller
                                            .isCheckPrivacyTermAndConditions
                                            .value,
                                    onChanged:
                                        controller
                                            .isCheckedPrivacyTermAndConditionsFunc,
                                  ),
                                  10.widthBox,
                                  Expanded(
                                    child: RichText(
                                      text: const TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "I agree to the ",
                                            style: TextStyle(
                                              //fontFamily: regular,
                                              color: greyColor,
                                            ),
                                          ),
                                          TextSpan(
                                            text: termAndCond,
                                            style: TextStyle(
                                              //fontFamily: regular,
                                              color: redColor,
                                            ),
                                          ),
                                          TextSpan(
                                            text: " & ",
                                            style: TextStyle(
                                              //fontFamily: regular,
                                              color: greyColor,
                                            ),
                                          ),
                                          TextSpan(
                                            text: privacyPolicy,
                                            style: TextStyle(
                                              //fontFamily: regular,
                                              color: redColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              5.heightBox,
                              ourButton(
                                    color: primaryColor,

                                    onPressed:
                                        controller.isLoading.value
                                            ? null
                                            : () {
                                              controller.register();
                                            },
                                    child:
                                        controller.isLoading.value
                                            ? CircularProgressIndicator(
                                              constraints: BoxConstraints.tight(
                                                Size.fromRadius(8.r),
                                              ),
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                    whiteColor,
                                                  ),
                                            )
                                            : Text(
                                              signup,
                                              style:
                                                  GoogleFonts.playfairDisplay(
                                                    color: whiteColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                  ).box
                                  .width(context.screenWidth - 50)
                                  .height(context.screenWidth / 9)
                                  .make(),

                              10.heightBox,

                              // wraping into gesture detector of velocity x
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  alreadyHaveAccount.text
                                      .color(greyColor)
                                      .make(),
                                  login.text.color(redColor).make().onTap(() {
                                    Get.back();
                                    controller.restFields();
                                  }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ).box.white.rounded
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
