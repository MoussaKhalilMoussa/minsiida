import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/category_controller/category_contorller.dart';
import 'package:simple_nav_bar/controllers/profile_controllers/profile/profile_controller.dart';
import 'package:simple_nav_bar/view/profile/model/user_profile.dart';
import 'package:simple_nav_bar/view/profile/pages/assistance.dart';
import 'package:simple_nav_bar/view/profile/pages/avis_et_evaluation_page.dart';
import 'package:simple_nav_bar/view/profile/pages/deconnection_page.dart';
import 'package:simple_nav_bar/view/profile/pages/mes_annonces_page.dart';
import 'package:simple_nav_bar/view/profile/pages/mes_favoris_page.dart';
import 'package:simple_nav_bar/view/profile/pages/messages_page.dart';
import 'package:simple_nav_bar/view/profile/pages/notifications_page.dart';
import 'package:simple_nav_bar/view/profile/pages/parametres_page.dart';
import 'package:simple_nav_bar/view/profile/pages/profile_page.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/authentication_steps.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/list_title.dart';

class Profile extends StatefulWidget {
  final VoidCallback? closeProfile;
  final Animation<Offset> offsetAnimation;

  const Profile({
    super.key,
    required this.closeProfile,
    required this.offsetAnimation,
  });

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  var isVehiculesOpen = false;
  int selectedIndex = 0;

  final categoryController = Get.find<CategoryContorller>();
  final profileController = Get.find<ProfileController>();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      
      UserProfile? profile = profileController.userProfile.value;

      if (profile == null) {
        return SlideTransition(
          position: widget.offsetAnimation,
          child: Material(
            color: Colors.white,
            child: const CircularProgressIndicator(color: primaryColor),
          ),
        ); // still loading
      }

      return SlideTransition(
        position: widget.offsetAnimation,
        child: Material(
          color: Colors.white,
          child: Stack(
            children: [
              Scaffold(
                backgroundColor: Colors.white,
                body: CustomScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      backgroundColor: Colors.white,
                      elevation: 1,
                      automaticallyImplyLeading: false,
                      title: Text(
                        "Profile",
                        style: GoogleFonts.poppins(
                          //fontWeight: FontWeight.bold,
                          color: greyColor,
                        ),
                      ),
                      actions: [
                        IconButton(
                          icon: Icon(Icons.close, color: blackColor2),
                          onPressed: widget.closeProfile,
                        ),
                      ],
                    ),
                    const SliverToBoxAdapter(child: Divider(height: 1)),
                    SliverToBoxAdapter(
                      child: Container(
                        width: MediaQuery.sizeOf(Get.context!).width,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemYellow,
                        ),
                        // the yellow container
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              alignment: Alignment.center,
                              width: 28.w,
                              height: 28.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: blackColor2,
                              ),
                              child: Text(
                                "i",
                                style: GoogleFonts.poppins(
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              "Verification  du vendeur",
                              style: GoogleFonts.poppins(
                                color: blackColor2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              alignment: Alignment.center,
                              width: 28.w,
                              height: 28.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: blackColor2,
                              ),
                              child: Text(
                                "3",
                                style: GoogleFonts.poppins(
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 0),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  LucideIcons.chevronRight,
                                  color: blackColor2,
                                  fill: 1,
                                  size: 28,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                Badge(
                                  offset: Offset(-8, -8),
                                  alignment: Alignment.bottomCenter,
                                  backgroundColor: CupertinoColors.systemYellow,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 3,
                                    horizontal: 6,
                                  ),
                                  label: Text(
                                    profile.subscription?.plan ?? 'Free',
                                    style: GoogleFonts.poppins(
                                      color: whiteColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 70.w,
                                    height: 70.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40.w),
                                      color: blueColor.withValues(alpha: 0.30),
                                    ),
                                    child:
                                        profile.profilePicture == null ||
                                                profile.profilePicture!.isEmpty
                                            ? Text(
                                              profile.name != null &&
                                                      profile.name!.isNotEmpty
                                                  ? profile.name![0]
                                                      .toUpperCase()
                                                  : "?",
                                              style: GoogleFonts.poppins(
                                                color: blueColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.sp,
                                              ),
                                            )
                                            : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(40.w),
                                              child: Image.network(
                                                profile.profilePicture!,
                                                width: 70.w,
                                                height: 70.h,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                  ),
                                
                                
                                ),
                                SizedBox(width: 12.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${profile.name}",
                                      style: GoogleFonts.poppins(
                                        color: blackColor2,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          "0",
                                          style: GoogleFonts.poppins(
                                            color: greyColor,
                                          ),
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          "abonnement",
                                          style: GoogleFonts.poppins(
                                            color: greyColor,
                                          ),
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          "0",
                                          style: GoogleFonts.poppins(
                                            color: greyColor,
                                          ),
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          "abonné",
                                          style: GoogleFonts.poppins(
                                            color: greyColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Spacer(),
                                TextButton(
                                  onPressed: () {
                                    Get.to(
                                      () => ProfilePage(),
                                      transition: Transition.rightToLeft,
                                      duration: const Duration(
                                        milliseconds: 150,
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Modifier",
                                    style: GoogleFonts.poppins(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          AuthenticationSteps(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            currentStep: 3, // or any dynamic value
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white),
                        height:
                            MediaQuery.sizeOf(Get.context!).height /
                            1.9, // Set height to allow scrolling
                        //height: 440.h,
                        child: ListView(
                          ///physics: BouncingScrollPhysics(),
                          children: [
                            listTitle(
                              selected: selectedIndex == 2,
                              title: "Profile",
                              leadingIcon: Ionicons.person_outline,
                              trailingIcon: Ionicons.chevron_forward_outline,
                              onTap: () {
                                setState(() {
                                  selectedIndex = 2;
                                });
                                Get.to(
                                  () => ProfilePage(),
                                  transition: Transition.rightToLeft,
                                  duration: const Duration(milliseconds: 150),
                                );
                              },
                            ),
                            listTitle(
                              selected: selectedIndex == 3,
                              title: "Publier une annonce",
                              leadingIcon: Ionicons.add_circle_outline,
                              trailingIcon: Ionicons.chevron_forward_outline,
                              onTap: () {
                                setState(() {
                                  selectedIndex = 3;
                                });
                                Navigator.pushNamed(context, '/addPost');
                              },
                            ),
                            listTitle(
                              selected: selectedIndex == 4,
                              title: "Mes annonces",
                              leadingIcon: Ionicons.megaphone_outline,
                              trailingIcon: Ionicons.chevron_forward_outline,
                              onTap: () {
                                setState(() {
                                  selectedIndex = 4;
                                });

                                Get.to(() => MesAnnoncesPage());
                              },
                            ),

                            listTitle(
                              selected: selectedIndex == 5,
                              title: 'Favoris',
                              leadingIcon: Ionicons.heart_outline,
                              trailingIcon: Ionicons.chevron_forward_outline,
                              onTap: () {
                                setState(() {
                                  selectedIndex = 5;
                                });
                                Get.to(() => MesFavoris());
                              },
                            ),
                            listTitle(
                              selected: selectedIndex == 6,
                              title: 'Messages',
                              leadingIcon: Ionicons.chatbubble_outline,
                              trailingIcon: Ionicons.chevron_forward_outline,
                              onTap: () {
                                setState(() {
                                  selectedIndex = 6;
                                });
                                Get.to(() => MessagesPage());
                              },
                            ),
                            listTitle(
                              selected: selectedIndex == 7,
                              title: 'Notifications',
                              leadingIcon: Ionicons.notifications_outline,
                              trailingIcon: Ionicons.chevron_forward_outline,
                              onTap: () {
                                setState(() {
                                  selectedIndex = 7;
                                });
                                Get.to(() => NotificationsPage());
                              },
                            ),
                            listTitle(
                              selected: selectedIndex == 8,
                              title: 'Avis',
                              leadingIcon: Ionicons.star_outline,
                              trailingIcon: Ionicons.chevron_forward_outline,
                              onTap: () {
                                setState(() {
                                  selectedIndex = 8;
                                });
                                Get.to(() => AvisEtEvaluationPage());
                              },
                            ),
                            listTitle(
                              selected: selectedIndex == 13,
                              title: "Paramètres",
                              leadingIcon: Ionicons.settings_outline,
                              trailingIcon: Ionicons.chevron_forward_outline,
                              onTap: () {
                                setState(() {
                                  selectedIndex = 13;
                                });
                                Get.to(() => ParametresPage());
                              },
                            ),
                            listTitle(
                              selected: selectedIndex == 14,
                              title: "Assistance",
                              leadingIcon: Ionicons.help_circle_outline,
                              trailingIcon: Ionicons.chevron_forward_outline,
                              onTap: () {
                                setState(() {
                                  selectedIndex = 14;
                                });
                                Get.to(() => AideEtSupport());
                              },
                            ),
                            listTitle(
                              selected: selectedIndex == 15,
                              title: "Déconnexion",
                              leadingIcon: Ionicons.exit_outline,
                              trailingIcon: Ionicons.chevron_forward_outline,
                              onTap: () {
                                setState(() {
                                  selectedIndex = 15;
                                });
                                Get.to(() => DeconnectionPage());
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
