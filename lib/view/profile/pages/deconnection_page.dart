import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/constants/strings.dart';
import 'package:simple_nav_bar/controllers/auth/auth_login_controller.dart';
import 'package:simple_nav_bar/utiles/token_utils.dart';
import 'package:simple_nav_bar/view/auth/login_screen.dart';

class DeconnectionPage extends StatelessWidget {
  DeconnectionPage({super.key});
  final authController = Get.find<AuthLoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: CustomScrollView(
        //physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
            backgroundColor: whiteColor,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Ionicons.chevron_back_outline),
              onPressed: () => Navigator.of(context).pop(),
            ),
            centerTitle: true,
            title: Text(
              'Déconnexion',
              style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold),
            ),
            floating: true,
            snap: true,
          ),
          const SliverToBoxAdapter(child: Divider(height: 1)),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                width: MediaQuery.sizeOf(Get.context!).width,
                margin: EdgeInsets.only(
                  right: 12,
                  left: 12,
                  top: MediaQuery.sizeOf(Get.context!).height / 5,
                ),
                //alignment: Alignment.bottomCenter,
                child: Card(
                  color: whiteColor,

                  child: Container(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 4),
                        CircleAvatar(
                          backgroundColor: redColor.withValues(alpha: 0.1),

                          radius: 40.r,
                          child: Icon(
                            Ionicons.exit_outline,
                            color: redColor,
                            size: 30,
                          ),
                        ),

                        SizedBox(height: 12.h),
                        Text(
                          'Êtes-vous sûr de vouloir vous déconnecter ?',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: greyColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: MediaQuery.sizeOf(Get.context!).width * 0.8,
                          child: Text(
                            'Vous serez déconnecté de votre compte et redirigé vers la page de connexion.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 14,
                              //fontWeight: FontWeight.bold,
                              color: blackColor2,
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        // deconnection button
                        ElevatedButton(
                          style: ButtonStyle(
                            visualDensity: VisualDensity.comfortable,
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(8),
                              ),
                            ),
                            fixedSize: WidgetStatePropertyAll(
                              Size(double.maxFinite, 50.h),
                            ),
                            //fixedSize:   ,
                            backgroundColor: WidgetStatePropertyAll(redColor),
                            shadowColor: WidgetStatePropertyAll(
                              Colors.transparent,
                            ),
                            padding: WidgetStatePropertyAll(
                              EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                            ),
                            foregroundColor: WidgetStatePropertyAll(whiteColor),
                          ),
                          onPressed: () async {
                            TokenUtils.clear();
                            authController.clearFields();
                            Get.to(() => LoginScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Ionicons.exit_outline, size: 18),
                              SizedBox(width: 8.w),
                              Text(
                                "Déconnexion",
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8.h),
                        ElevatedButton(
                          style: ButtonStyle(
                            visualDensity: VisualDensity.comfortable,
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(8),
                              ),
                            ),
                            fixedSize: WidgetStatePropertyAll(
                              Size(double.maxFinite, 50.h),
                            ),
                            //fixedSize:   ,
                            backgroundColor: WidgetStatePropertyAll(
                              greyColor.withValues(alpha: 0.1),
                            ),
                            shadowColor: WidgetStatePropertyAll(
                              Colors.transparent,
                            ),
                            padding: WidgetStatePropertyAll(
                              EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                            ),
                            foregroundColor: WidgetStatePropertyAll(whiteColor),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Ionicons.close_outline,
                                size: 18,
                                color: greyColor,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "Annuler",
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: blackColor2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
