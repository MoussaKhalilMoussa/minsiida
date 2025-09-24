import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
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

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var controller = Get.find<AuthLoginController>();

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (MediaQuery.sizeOf(Get.context!).height * 0.15).heightBox,
              applogoWidget(),
              10.heightBox,
              "Bienvenue à $appname".text
                  .fontWeight(FontWeight.bold)
                  .color(primaryColor)
                  .size(18)
                  .make(),
              15.heightBox,
              Obx(
                () => Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child:
                      Column(
                            children: [
                              customeTextField(
                                title: userName,
                                hint: userNameHint,
                                isPass: false,
                                controller: controller.userNameController,
                                onChanged: (value) {
                                  controller.userNameController.text = value;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Le mot de passe est requis";
                                  }
                                  return null;
                                },
                              ),
                              customeTextField(
                                title: password,
                                hint: passwordHint,
                                isPass: true,
                                controller: controller.passwordController,
                                onChanged: (value) {
                                  controller.passwordController.text = value;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Le mot de passe est requis";
                                  }
                                  return null;
                                },
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    Get.dialog(
                                      Dialog(
                                        backgroundColor: whiteColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const SizedBox(height: 2),
                                              Form(
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                key: _formKey2,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Veuillez entrer votre e-mail",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: blackColor2,
                                                      ),
                                                    ),
                                                    customeTextField(
                                                      title: "",
                                                      hint: "exemple@gmail.com",
                                                      isPass: false,
                                                      onChanged: (value) {
                                                        controller
                                                            .emailController
                                                            .text = value;
                                                      },
                                                      controller:
                                                          controller
                                                              .emailController,
                                                      validator: (value) {
                                                        return controller
                                                            .validateEmail(
                                                              value!,
                                                            );
                                                      },
                                                      onSaved: (value) {
                                                        controller.email =
                                                            value!;
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      foregroundColor:
                                                          whiteColor,
                                                      backgroundColor: redColor,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      controller
                                                          .emailController
                                                          .text = "";
                                                      controller.email = "";
                                                      Get.back(); // close dialog
                                                      Get.off(
                                                        () => LoginScreen(),
                                                      ); // go to login
                                                    },
                                                    child: const Text(
                                                      "Annuler",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: whiteColor,
                                                      ),
                                                    ),
                                                  ),

                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      foregroundColor:
                                                          whiteColor,
                                                      backgroundColor:
                                                          primaryColor,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                      ),
                                                    ),
                                                    onPressed: () async {
                                                      if (_formKey2
                                                          .currentState!
                                                          .validate()) {
                                                        //Get.back(); // close dialog
                                                        await controller
                                                            .resetByEmailMethod(
                                                              context: context,
                                                            );
                                                      }
                                                      /* Get.off(
                                                        () => LoginScreen(),
                                                      ); */ // go to login
                                                    },
                                                    child: const Text(
                                                      "Envoyer",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: whiteColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      barrierDismissible: false,
                                    );
                                  },
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
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                await controller.loginMethod(
                                                  context: context,
                                                );
                                              }
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
                                              login,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
