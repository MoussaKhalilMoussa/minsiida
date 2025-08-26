import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/notifications_controller.dart/notifications_controller.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var notificationController = Get.find<NotificationsController>();

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
              'Notifications',
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
                  var isTousTabSelected =
                      notificationController.isTousTabSelected.value;
                  var isNonLusTabSelected =
                      notificationController.isNonLusTabSelected.value;
                  var isMessagesTabSelected =
                      notificationController.isMessagesTabSelected.value;
                  var isOffresTabSelected =
                      notificationController.isOffresTabSelected.value;
                  var notificationText =
                      notificationController.notificationText.value;
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              notificationController.isTousTabSelectedFunc();
                            },
                            child: Chip(
                              side: BorderSide.none,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              label: Text(
                                'Tous',
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      isTousTabSelected
                                          ? whiteColor
                                          : blackColor2,
                                ),
                              ),
                              backgroundColor:
                                  isTousTabSelected ? primaryColor : whiteColor,
                            ),
                          ),

                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              notificationController.isNonLusTabSelectedFunc();
                            },
                            child: Chip(
                              side: BorderSide.none,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              label: Text(
                                'Non lus',
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      isNonLusTabSelected
                                          ? whiteColor
                                          : blackColor2,
                                ),
                              ),
                              backgroundColor:
                                  isNonLusTabSelected
                                      ? primaryColor
                                      : whiteColor,
                            ),
                          ),
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              notificationController
                                  .isMessagesTabSelectedFunc();
                            },
                            child: Chip(
                              side: BorderSide.none,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              label: Text(
                                'Messages',
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      isMessagesTabSelected
                                          ? whiteColor
                                          : blackColor2,
                                ),
                              ),
                              backgroundColor:
                                  isMessagesTabSelected
                                      ? primaryColor
                                      : whiteColor,
                            ),
                          ),
                          SizedBox(width: 8),

                          GestureDetector(
                            onTap: () {
                              notificationController.isOffresTabSelectedFunc();
                            },
                            child: Chip(
                              side: BorderSide.none,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              label: Text(
                                'Offres',
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      isOffresTabSelected
                                          ? whiteColor
                                          : blackColor2,
                                ),
                              ),
                              backgroundColor:
                                  isOffresTabSelected
                                      ? primaryColor
                                      : whiteColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              notificationText,
                              style: GoogleFonts.playfairDisplay(
                                color: blackColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Chip(
                            padding: EdgeInsets.all(2),
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            label: Text(
                              'Tout marquer lu',
                              style: GoogleFonts.playfairDisplay(
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            backgroundColor: primaryColor.withValues(
                              alpha: 0.1,
                            ),
                          ),
                          SizedBox(width: 8),
                          Chip(
                            padding: EdgeInsets.all(2),
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            label: Text(
                              'Tout effacer',
                              style: GoogleFonts.playfairDisplay(
                                color: redColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            backgroundColor: redColor.withValues(alpha: 0.1),
                          ),
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
