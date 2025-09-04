import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_nav_bar/common_widgets/applogo.dart';
import 'package:simple_nav_bar/common_widgets/bg_widget.dart';
import 'package:simple_nav_bar/common_widgets/custom_textfield.dart';
import 'package:simple_nav_bar/common_widgets/ourbuttton.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/constants/lists.dart';
import 'package:simple_nav_bar/constants/strings.dart';
import 'package:simple_nav_bar/controllers/auth/auth_controller.dart';
import 'package:simple_nav_bar/view/auth/sign_up_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<AuthController>();
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
                                child: forgetPass.text.make(),
                              ),
                            ),
                            5.heightBox,
                            controller.isLoading.value
                                ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                    primaryColor,
                                  ),
                                )
                                : ourButton(
                                  onPress: () async {
                                    /* controller.isLoading(true);
                                    await controller
                                        .loginMethod(context: context)
                                        .then((value) {
                                          if (value != null) {
                                            VxToast.show(
                                              context,
                                              msg: loggedin,
                                            );
                                            Get.offAll(() => const Home());
                                          } else {
                                            controller.isLoading(false);
                                          }
                                        }); */
                                  },
                                  color: primaryColor,
                                  textColor: whiteColor,
                                  title: login,
                                ).box.width(context.screenWidth - 50).make(),
                            5.heightBox,
                            createNewAccount.text.color(greyColo1).make(),
                            5.heightBox,
                            ourButton(
                              onPress: () {
                                Get.to(() => const SignupScreen());
                              },
                              color: whiteColor,
                              textColor: blackColor2,
                              title: signup,
                            ).box.width(context.screenWidth - 50).make(),
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
