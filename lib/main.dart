import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/controllers/category_controller/category_contorller.dart';
import 'package:simple_nav_bar/controllers/delivery_controller/delivery_controller.dart';
import 'package:simple_nav_bar/controllers/details_page_controller/details_page_controller.dart';
import 'package:simple_nav_bar/controllers/home_controller/home_controller.dart';
import 'package:simple_nav_bar/controllers/location_controller/location_controller.dart';
import 'package:simple_nav_bar/controllers/specifications/specification_controller.dart';
import 'package:simple_nav_bar/view/post/screen/add_post_screen.dart';
import 'view/home/screen/home.dart';

void main() {
  Get.lazyPut<LocationController>(() => LocationController());
  Get.lazyPut<DetailsPageController>(() => DetailsPageController());
  Get.lazyPut<SpecificationController>(() => SpecificationController());
  Get.lazyPut<DeliveryController>(() => DeliveryController());
  Get.lazyPut<CategoryContorller>(() => CategoryContorller());
  Get.lazyPut<HomeController>(() => HomeController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812), // base design screen size
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Simple Nav Bar',
          theme: ThemeData(
            textTheme: GoogleFonts.playfairDisplayTextTheme(),
            primarySwatch: Colors.purple,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
            ),
          ),
          routes: {
            '/addPost': (context) => AddPostScreen(),
            '': (context) => HomeScreen(),
          },
          home: HomeScreen(),
        );
      },
    );
  }
}
