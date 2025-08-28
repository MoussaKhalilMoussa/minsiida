import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/category_controller/category_contorller.dart';
import 'package:simple_nav_bar/view/profile/pages/assistance_page.dart';
import 'package:simple_nav_bar/view/profile/pages/deconnection_page.dart';
import 'package:simple_nav_bar/view/profile/pages/mes_annonces.dart';
import 'package:simple_nav_bar/view/profile/pages/mes_favoris.dart';
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
                      "User",
                      style: GoogleFonts.playfairDisplay(
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
                              style: GoogleFonts.playfairDisplay(
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "Satıcı Doğrulama",
                            style: GoogleFonts.playfairDisplay(
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
                              style: GoogleFonts.playfairDisplay(
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: .0),
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
                                  "Premium",
                                  style: GoogleFonts.playfairDisplay(
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
                                  child: Text(
                                    "J",
                                    style: GoogleFonts.playfairDisplay(
                                      color: blueColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp,
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
                                    "Jessica Anderson",
                                    style: GoogleFonts.playfairDisplay(
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
                                        style: GoogleFonts.playfairDisplay(
                                          color: greyColor,
                                        ),
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        "Takip",
                                        style: GoogleFonts.playfairDisplay(
                                          color: greyColor,
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        "0",
                                        style: GoogleFonts.playfairDisplay(
                                          color: greyColor,
                                        ),
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        "Takipçi",
                                        style: GoogleFonts.playfairDisplay(
                                          color: greyColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Düzen",
                                  style: GoogleFonts.playfairDisplay(
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
                      //height: MediaQuery.sizeOf(Get.context!).height, // Set height to allow scrolling
                      height: 440.h,
                      child: ListView(
                        ///physics: BouncingScrollPhysics(),
                        children: [
                          /* listTitle(
                            selected: selectedIndex == 1,
                            title: "Tableau de bord",
                            leadingIcon: Ionicons.home_outline,
                            trailingIcon: Ionicons.chevron_forward_outline,
                            onTap: () {
                              setState(() {
                                selectedIndex = 1;
                              });
                              Get.to(() => TableauDeBoard(),
                                  transition: Transition.rightToLeft,
                                  duration: const Duration(milliseconds: 150));
                            },
                          ), */
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
                              Get.to(() => MesAnnonces());
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
                          /* 
                          listTitle(
                            selected: selectedIndex == 8,
                            title: 'Mes Commandes',
                            leadingIcon: Ionicons.cart_outline,
                            trailingIcon: Ionicons.chevron_forward_outline,
                            onTap: () {
                              setState(() {
                                selectedIndex = 8;
                              });
                              print("Mes Commandes tapped");
                            },
                          ),
                          listTitle(
                            selected: selectedIndex == 9,
                            title: 'Offres',
                            leadingIcon: Ionicons.document_text_outline,
                            trailingIcon: Ionicons.chevron_forward_outline,
                            onTap: () {
                              setState(() {
                                selectedIndex = 9;
                              });
                              print("Offres tapped");
                            },
                          ),
                          listTitle(
                            selected: selectedIndex == 10,
                            title: "Gains",
                            leadingIcon: Ionicons.briefcase_outline,
                            trailingIcon: Ionicons.chevron_forward_outline,
                            onTap: () {
                              setState(() {
                                selectedIndex = 10;
                              });
                              print("Gains tapped");
                            },
                          ),
                          listTitle(
                            selected: selectedIndex == 11,
                            title: 'Avis',
                            leadingIcon: Ionicons.star_outline,
                            trailingIcon: Ionicons.chevron_forward_outline,
                            onTap: () {
                              setState(() {
                                selectedIndex = 11;
                              });
                              print("Avis tapped");
                            },
                          ),
                          listTitle(
                            selected: selectedIndex == 12,
                            title: 'Reseau',
                            leadingIcon: Ionicons.people_outline,
                            trailingIcon: Ionicons.chevron_forward_outline,
                            onTap: () {
                              setState(() {
                                selectedIndex = 12;
                              });
                              print("Reseau tapped");
                            },
                          ), */
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
                              Get.to(() => AssistancePage());
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
                  /* 
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ListTile(
                          leading: Icon(LucideIcons.user, color: blackColor2),
                          title: Text(
                            "Hesap Ayarları",
                            style: GoogleFonts.playfairDisplay(
                              color: blackColor2,
                            ),
                          ),
                          trailing: Icon(
                            LucideIcons.chevronRight,
                            color: blackColor2,
                          ),
                          onTap: () {
                            // Handle tap
                          },
                        );
                      },
                      childCount: 10, // Example item count
                    ),
                  ),
                 */
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
