import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/product_controller/post_details_controller.dart';
import 'package:simple_nav_bar/utiles/utitlity_functions.dart';
import 'package:simple_nav_bar/view/profile/model/user_profile.dart';

class ProfleSummary extends StatelessWidget {
  ProfleSummary({super.key});
  final postDetailsController = Get.find<PosttDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final UserProfile? user = postDetailsController.postUser.value;
      return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: BoxBorder.all(color: greyColo1.withValues(alpha: 0.6)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 35.sp,
                  backgroundColor: Colors.teal,
                  backgroundImage:
                      user!.profilePicture != null
                          ? NetworkImage(user.profilePicture!)
                          : null,
                  child:
                      user.profilePicture == null
                          ? Text(
                            user.name![0].toUpperCase(),
                            style: GoogleFonts.poppins(
                              color: whiteColor,
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                          : null,
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.poppins(
                        color: blackColor2,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      "Membre depuis ${extractMonthYear(user.createdAt!)}",
                      style: GoogleFonts.poppins(
                        color: greyColor,
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        int starIndex = index + 1;
                        return Icon(
                          size: 16,
                          Ionicons.star,
                          color:
                              4 >= starIndex
                                  ? Colors.amber
                                  : 4 >= starIndex - 0.5
                                  ? Colors.amberAccent
                                  : Colors.grey[300],
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            _localReusableWidget(
              icon: LucideIcons.clock3,
              text: "Derniere activite it y a 18 heures",
            ),
            _localReusableWidget(
              icon: LucideIcons.messageCircle,
              text: "Reponse en moyenne en 1 h",
            ),
            _localReusableWidget(
              icon: LucideIcons.clock3,
              text: "Derniere activite it y a 18 heures",
            ),
          ],
        ),
      );
    });
  }

  Widget _localReusableWidget({required IconData? icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(icon, color: greyColor),
          SizedBox(width: 12),
          Text(
            text,
            style: GoogleFonts.poppins(
              color: greyColor,
              fontWeight: FontWeight.w300,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
