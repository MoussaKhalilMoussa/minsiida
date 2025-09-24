import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/profile_controllers/notifications_controller.dart/notifications_controller.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/notification_card.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/notification_tab.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationController = Get.find<NotificationsController>();

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
                  var isRead = notificationController.isRead.value;
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
                            SizedBox(width: 8),
                            notificationTab(
                              onTap: () {
                                notificationController
                                    .isNonLusTabSelectedFunc();
                              },
                              label: 'Non lus',
                              color:
                                  isNonLusTabSelected
                                      ? whiteColor
                                      : blackColor2,
                              backgroundColor:
                                  isNonLusTabSelected
                                      ? primaryColor
                                      : whiteColor,
                            ),
                            SizedBox(width: 8),
                            notificationTab(
                              onTap: () {
                                notificationController
                                    .isMessagesTabSelectedFunc();
                              },
                              label: 'Messages',
                              color:
                                  isMessagesTabSelected
                                      ? whiteColor
                                      : blackColor2,
                              backgroundColor:
                                  isMessagesTabSelected
                                      ? primaryColor
                                      : whiteColor,
                            ),
                            SizedBox(width: 8),
                            notificationTab(
                              onTap: () {
                                notificationController
                                    .isOffresTabSelectedFunc();
                              },
                              label: 'Offres',
                              color:
                                  isOffresTabSelected
                                      ? whiteColor
                                      : blackColor2,
                              backgroundColor:
                                  isOffresTabSelected
                                      ? primaryColor
                                      : whiteColor,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 10.h),
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
                          SizedBox(width: 8.w),
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

                      //SizedBox(height:8),
                      // List of notifications
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 10,
                        separatorBuilder:
                            (context, index) => SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          return buildNotificationCard(
                            onTap: () {
                              notificationController.isReadFunc();
                            },
                            title: "Notification",
                            time: "2 hours ago",
                            description: "This is a sample notification.",
                            isRead: isRead,
                          );
                        },
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
