import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/controllers/initail_bindings.dart';
import 'package:simple_nav_bar/view/post/screen/add_post_screen.dart';
import 'package:simple_nav_bar/view/splash/splash_scren.dart';
import 'view/home/screen/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
          initialBinding: InitialBinding(),
          debugShowCheckedModeBanner: false,
          title: 'Minsida',
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
            //'': (context) => SplashScren(),
          },
          home: SplashScren(),
        );
      },
    );
  }
}
