import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/profile_controllers/avis_et_evaluation_controller/avis_et_evaluation_controller.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/notification_compoents/notification_tab.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/review_components/ratings_summary.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/review_components/review_card.dart';

class AvisEtEvaluationPage extends StatelessWidget {
  const AvisEtEvaluationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationController = Get.find<AvisEtEvaluationController>();

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
              'Avis & Evaluations',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: blackColor,
              ),
            ),
            floating: true,
            snap: true,
          ),
          SliverToBoxAdapter(child: Divider(height: 1.h)),
          SliverList(
            delegate: SliverChildListDelegate([
              AnimatedContainer(
                duration: Duration(seconds: 1),
                width: MediaQuery.sizeOf(Get.context!).width,
                margin: EdgeInsets.only(right: 12, left: 12, top: 20),

                child: Obx(() {
                  var isTousTabSelected =
                      notificationController.isTousTabSelected.value;
                  var isPositifs = notificationController.isPositifs.value;
                  var isNeutres = notificationController.isNeutres.value;
                  var isNegatifs = notificationController.isNegatifs.value;
                  return Column(
                    children: [
                      Container(
                        height: 36.h,
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.sizeOf(context).width,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            notificationTab(
                              onTap: () {
                                notificationController.isTousTabSelectedFunc();
                              },
                              label: 'Tous',
                              color:
                                  isTousTabSelected ? whiteColor : blackColor2,
                              backgroundColor:
                                  isTousTabSelected ? primaryColor : whiteColor,
                            ),
                            SizedBox(width: 8.w),
                            notificationTab(
                              onTap: () {
                                notificationController.isPositifsFunc();
                              },
                              label: 'Positifs (4-5 ★)',
                              color: isPositifs ? whiteColor : blackColor2,
                              backgroundColor:
                                  isPositifs ? primaryColor : whiteColor,
                            ),
                            SizedBox(width: 8.w),
                            notificationTab(
                              onTap: () {
                                notificationController.isNeutresFunc();
                              },
                              label: 'Neutres (3 ★)',
                              color: isNeutres ? whiteColor : blackColor2,
                              backgroundColor:
                                  isNeutres ? primaryColor : whiteColor,
                            ),
                            SizedBox(width: 8.w),
                            notificationTab(
                              onTap: () {
                                notificationController.isNegatifsFunc();
                              },
                              label: 'Négatifs (1-2 ★)',
                              color: isNegatifs ? whiteColor : blackColor2,
                              backgroundColor:
                                  isNegatifs ? primaryColor : whiteColor,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16.h),

                      AnimatedContainer(
                        duration: Duration(seconds: 2),
                        padding: EdgeInsets.all(12),
                        width: MediaQuery.sizeOf(Get.context!).width,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            RatingSummary(
                              averageRating: 4.8,
                              totalReviews: 48,
                              ratingDistribution: {
                                5: 100,
                                4: 15,
                                3: 5,
                                2: 0,
                                1: 0,
                              },
                            ),

                            SizedBox(height: 8),
                            SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Avis récents",
                                    style: GoogleFonts.poppins(
                                      color: greyColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      foregroundColor: WidgetStatePropertyAll(
                                        primaryColor,
                                      ),
                                    ),
                                    child: Text("Voir tout",style: GoogleFonts.poppins(),),
                                  ),
                                ],
                              ),
                            ),

                            ListView.separated(
                              separatorBuilder:
                                  (context, index) => SizedBox(height: 18.h),
                              itemCount: 2,
                              shrinkWrap:
                                  true, // ✅ makes ListView take only required space
                              physics:
                                  const NeverScrollableScrollPhysics(), // ✅ disable inner scroll
                              itemBuilder: (context, index) {
                                return ReviewCard(
                                  userName: "Jean Dupont",
                                  reviewDate: "25 octobre 2023",
                                  rating: 5,
                                  reviewText:
                                      "Excellent vendeur ! L'article était exactement comme décrit et l'envoi a été rapide.Excellent vendeur ! L'article était exactement comme décrit et l'envoi a été rapide.",
                                  productName: "iPhone 12 Pro Max",
                                );
                              },
                            ),
                          ],
                        ),
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
