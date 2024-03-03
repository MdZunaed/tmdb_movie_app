import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controller/bottom_nav_controller.dart';
import 'package:movie_app/controller/home_screen_controller.dart';
import 'package:movie_app/controller/movie_details_controller.dart';
import 'package:movie_app/controller/movie_list_controller.dart';
import 'package:movie_app/controller/tv_details_controller.dart';
import 'package:movie_app/controller/tv_list_controller.dart';
import 'package:movie_app/screen/splash_screen.dart';
import 'package:movie_app/utility/app_colors.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: ControllerBinders(),
      title: "MOOVI",
      home: const SplashScreen(),
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepOrange, backgroundColor: bgColor),
        appBarTheme: const AppBarTheme(backgroundColor: bgColor),
      ),
    );
  }
}

class ControllerBinders extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavController());
    Get.put(HomeScreenController());
    Get.put(MovieListController());
    Get.put(MovieDetailsController());
    Get.put(TvListController());
    Get.put(TvDetailsController());
  }
}
