import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/constants/colors.dart';

class AuthenticationSteps extends StatefulWidget {
  final double width;
  final double height;
  late int currentStep;

  AuthenticationSteps({
    super.key,
    required this.width,
    required this.height,
    this.currentStep = 3,
  });

  @override
  State<AuthenticationSteps> createState() => _AuthenticationStepsState();
}

class _AuthenticationStepsState extends State<AuthenticationSteps> {
  late PageController _pageController;
  late int _currentStep;

  final List<String> steps = const [
    "Kimlik",
    "Fotoğraf",
    "Telefon",
    "Email",
    "Adres",
    "Onay",
  ];

  @override
  void initState() {
    super.initState();
    _currentStep = widget.currentStep;
    _pageController = PageController(initialPage: _currentStep);

    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? _currentStep;
      if (page != _currentStep) {
        setState(() {
          _currentStep = page;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),

      //margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top bar with title and "Devam Et"
          SizedBox(
            width: widget.width,
            height: 40.h,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  child: Container(
                    width: widget.width * 0.7,
                    height: 40.h,
                    alignment: Alignment.centerLeft,
                    child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: steps.length,
                      controller: _pageController,
                      itemBuilder: (context, index) {
                        return Text(
                          steps[index],
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color:
                                index == widget.currentStep
                                    ? blackColor2
                                    : greyColor.withValues(alpha: 0.8),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    alignment: Alignment.centerRight,
                    width: 30.w,
                    height: 30.h,
                    child: TextButton(
                      onPressed: () {
                        if (_currentStep <= steps.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );

                          setState(() {
                            _currentStep++;
                            widget.currentStep = _currentStep;
                          });
                        }
                        // Navigate to the next step or perform an action
                      },
                      child: Icon(
                        CupertinoIcons.forward,
                        color: CupertinoColors.activeOrange,
                        size: 25.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 18.h),

          // Step labels
          /* Row(
            children: List.generate(
              steps.length,
              (index) => Expanded(
                child: Center(
                  child: Text(
                    steps[index],
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 11.sp,
                      fontWeight: index == widget.currentStep
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: index == widget.currentStep
                          ? blackColor2
                          : greyColor.withValues(alpha:0.8),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h), */

          // Step indicators
          Row(
            children: List.generate(
              steps.length,
              (index) => Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  height: 8.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color:
                        index < widget.currentStep
                            ? CupertinoColors.activeOrange
                            : CupertinoColors.inactiveGray,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 10.h),

          // Progress summary
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "${widget.currentStep} / ${steps.length} tamamlandı",
              style: GoogleFonts.playfairDisplay(
                fontSize: 12.sp,
                color: greyColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
