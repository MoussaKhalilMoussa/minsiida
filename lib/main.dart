import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/controllers/delivery_controller/delivery_controller.dart';
import 'package:simple_nav_bar/controllers/details_page_controller/details_page_controller.dart';
import 'package:simple_nav_bar/controllers/location_controller/location_controller.dart';
import 'package:simple_nav_bar/controllers/specifications/specification_controller.dart';
import 'package:simple_nav_bar/view/post/screen/add_post_screen.dart';
import 'view/home/home.dart';

void main() {
  Get.lazyPut<LocationController>(() => LocationController());
  Get.lazyPut<DetailsPageController>(() => DetailsPageController());
  Get.lazyPut<SpecificationController>(() => SpecificationController());
  Get.lazyPut<DeliveryController>(() => DeliveryController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Nav Bar',
      theme: ThemeData(
        textTheme: GoogleFonts.playfairDisplayTextTheme(),
        primarySwatch: Colors.purple,
      ),
      routes: {
        '/addPost': (context) => AddPostScreen(),
        '': (context) => HomeScreen(),
      },
      home: HomeScreen(),
    );
  }
}
