import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/delivery_controller/delivery_controller.dart';

class DeliveryMethodCard extends StatelessWidget {
  final String methodTitle;
  final String methodSubtitle;
  bool showRecommandation;

  DeliveryMethodCard({
    super.key,
    required this.methodTitle,
    required this.methodSubtitle,
    this.showRecommandation = false,
  });

  final DeliveryController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(() {
        final isSelected = controller.selectedMethod.value == methodTitle;

        return GestureDetector(
          onTap: () => controller.selectMethod(methodTitle),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: isSelected ? blueColor : Colors.grey.shade300,
                width: 0.5,
              ),
            ),
            color: isSelected ? Colors.blue.shade50 : Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15,
                children: [
                  // Left side: Texts
                  Icon(
                    isSelected
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    color: isSelected ? primaryColor : Colors.grey,
                  ),
                  // Right side: Checkbox-like icon area
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (!showRecommandation) ...[
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.topCenter,
                                width: 120,
                                height: 25,
                                padding: EdgeInsets.only(
                                  left: 4,
                                  right: 4,
                                  bottom: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: purple_600.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  "Recommandé",
                                  style: GoogleFonts.playfairDisplay(
                                    color: purple_600,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                alignment: Alignment.center,
                                width: 70,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: greenColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  "Min 50€",
                                  style: GoogleFonts.playfairDisplay(
                                    color: Colors.green.shade600,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                        ],
                        Text(
                          methodTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: blackColor2,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          methodSubtitle,
                          style: TextStyle(fontSize: 11, color: blackColor2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
