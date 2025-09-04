import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_nav_bar/common_widgets/applogo.dart';
import 'package:simple_nav_bar/common_widgets/bg_widget.dart';
import 'package:simple_nav_bar/common_widgets/custom_textfield.dart';
import 'package:simple_nav_bar/common_widgets/ourbuttton.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/constants/strings.dart';
import 'package:simple_nav_bar/controllers/auth/auth_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.find<AuthController>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              "Join the $appname".text
                  .fontWeight(FontWeight.bold)
                  .white
                  .size(18)
                  .make(),
              15.heightBox,
              Obx(
                    () => Column(
                      children: [
                        customeTextField(
                          title: name,
                          hint: nameHint,
                          controller: nameController,
                          isPass: false,
                        ),
                        customeTextField(
                          title: email,
                          hint: emailHint,
                          controller: emailController,
                          isPass: false,
                        ),
                        customeTextField(
                          title: password,
                          hint: passwordHint,
                          controller: passwordController,
                          isPass: true,
                        ),
                        customeTextField(
                          title: retypePassword,
                          hint: passwordHint,
                          controller: passwordRetypeController,
                          isPass: true,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {},
                            child: forgetPass.text.make(),
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                              //checkColor: primaryColor,
                              activeColor: primaryColor,
                              value: isCheck,
                              onChanged: (newValue) {
                                setState(() {
                                  isCheck = newValue;
                                });
                              },
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
                        controller.isLoading.value
                            ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(primaryColor),
                            )
                            : ourButton(
                              onPress: () async {
                                if (isCheck != false) {
                                  controller.isLoading(true);
                                  try {
                                    await controller
                                        .signupMethod(
                                          context: context,
                                          email: emailController.text,
                                          password: passwordController.text,
                                        )
                                        .then((value) {
                                          return controller.storeUserData(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            name: nameController.text,
                                          );
                                        })
                                        .then((value) {
                                          VxToast.show(context, msg: loggedin);
                                          //Get.offAll(() => const Home());
                                        });
                                  } catch (e) {
                                    //auth.signOut();
                                    VxToast.show(context, msg: e.toString());
                                    print(e.toString());
                                    controller.isLoading(false);
                                  }
                                }
                              },
                              color: isCheck == true ? primaryColor : lightGrey,
                              textColor:
                                  isCheck == true ? whiteColor : greyColor,
                              title: signup,
                            ).box.width(context.screenWidth - 50).make(),
                        10.heightBox,

                        // wraping into gesture detector of velocity x
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            alreadyHaveAccount.text.color(greyColor).make(),
                            login.text.color(redColor).make().onTap(() {
                              Get.back();
                            }),
                          ],
                        ),
                      ],
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
    );
  }
}
