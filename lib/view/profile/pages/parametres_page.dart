import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/profile_controllers/parametres_controller/parametres_controller.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/notification_tab.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/parameters_components_widgets/auth_a_deux_facteur_not_container.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/parameters_components_widgets/comptes_connecte_not_container.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/parameters_components_widgets/email_notification_container.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/parameters_components_widgets/para_des_confi_not_container.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/parameters_components_widgets/supprimer_le_compte_not_container.dart';

class ParametresPage extends StatelessWidget {
  const ParametresPage({super.key});

  @override
  Widget build(BuildContext context) {
    final parametresController = Get.find<ParametresController>();

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
              'Paramètres',
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
                margin: EdgeInsets.only(right: 12, left: 12, top: 20),
                child: Obx(() {
                  var isToutSelected =
                      parametresController.isToutSelected.value;
                  var isNotificationsSelected =
                      parametresController.isNotificationsSelected.value;
                  var isConfidentialiteSelected =
                      parametresController.isConfidentialiteSelected.value;
                  var isSecuritySelected =
                      parametresController.isSecuritySelected.value;

                  var isComptesLinkedSelected =
                      parametresController.isComptesLinkedSelected.value;
                  var label =
                      isToutSelected
                          ? 'Tout'
                          : isNotificationsSelected
                          ? 'Notifications'
                          : isConfidentialiteSelected
                          ? 'Confidentialité'
                          : isSecuritySelected
                          ? 'Sécurité'
                          : isComptesLinkedSelected
                          ? 'Comptes liés'
                          : 'Tout';

                  return Column(
                    children: [
                      Container(
                        height: 36,
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.sizeOf(context).width,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,

                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            notificationTab(
                              onTap: () {
                                parametresController.isToutSelectedFunc();
                              },
                              label: "Tout",
                              color: isToutSelected ? Colors.white : greyColor,
                              backgroundColor:
                                  isToutSelected ? primaryColor : whiteColor,
                              avatar: Icon(
                                Ionicons.globe_outline,
                                size: 16,
                                color:
                                    isToutSelected ? Colors.white : greyColor,
                              ),
                            ),
                            SizedBox(width: 8),
                            notificationTab(
                              onTap: () {
                                parametresController
                                    .isNotificationsSelectedFunc();
                              },
                              label: "Notifications",
                              color:
                                  isNotificationsSelected
                                      ? Colors.white
                                      : greyColor,
                              backgroundColor:
                                  isNotificationsSelected
                                      ? primaryColor
                                      : whiteColor,
                              avatar: Icon(
                                Ionicons.notifications_outline,
                                size: 16,
                                color:
                                    isNotificationsSelected
                                        ? Colors.white
                                        : greyColor,
                              ),
                            ),
                            SizedBox(width: 8),
                            notificationTab(
                              onTap: () {
                                parametresController
                                    .isConfidentialiteSelectedFunc();
                              },
                              label: "Confidentialité",
                              color:
                                  isConfidentialiteSelected
                                      ? Colors.white
                                      : greyColor,
                              backgroundColor:
                                  isConfidentialiteSelected
                                      ? primaryColor
                                      : whiteColor,
                              avatar: Icon(
                                Ionicons.eye_outline,
                                size: 16,
                                color:
                                    isConfidentialiteSelected
                                        ? Colors.white
                                        : greyColor,
                              ),
                            ),
                            SizedBox(width: 8),
                            notificationTab(
                              onTap: () {
                                parametresController.isSecuritySelectedFunc();
                              },
                              label: "Sécurité",
                              color:
                                  isSecuritySelected ? Colors.white : greyColor,
                              backgroundColor:
                                  isSecuritySelected
                                      ? primaryColor
                                      : whiteColor,
                              avatar: Icon(
                                Ionicons.lock_closed_outline,
                                size: 16,
                                color:
                                    isSecuritySelected
                                        ? Colors.white
                                        : greyColor,
                              ),
                            ),
                            SizedBox(width: 8),
                            notificationTab(
                              onTap: () {
                                parametresController
                                    .isComptesLinkedSelectedFunc();
                              },
                              label: "Comptes liés",
                              color:
                                  isComptesLinkedSelected
                                      ? Colors.white
                                      : greyColor,
                              backgroundColor:
                                  isComptesLinkedSelected
                                      ? primaryColor
                                      : whiteColor,
                              avatar: Icon(
                                Ionicons.link_outline,
                                size: 16,
                                color:
                                    isComptesLinkedSelected
                                        ? Colors.white
                                        : greyColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 10),
                      ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          const EmailNotificationContainer(),
                          SizedBox(height: 12.h),
                          const ParaDesConfiNotContainer(),
                          SizedBox(height: 12.h),
                          const AuthADeuxFacteurNotContainer(),
                          SizedBox(height: 12.h),
                          const ComptesConnecteNotContainer(),
                          SizedBox(height: 12.h),
                          const SupprimerLeCompteNotContainer(),
                        ],
                      ),
                    ],
                  );
                }),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
