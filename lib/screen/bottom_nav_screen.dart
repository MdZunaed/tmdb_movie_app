import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:movie_app/controller/bottom_nav_controller.dart';
import 'package:movie_app/controller/home_screen_controller.dart';
import 'package:movie_app/controller/movie_list_controller.dart';
import 'package:movie_app/controller/tv_list_controller.dart';
import 'package:movie_app/screen/home_screen.dart';
import 'package:movie_app/screen/movie_list_screen.dart';
import 'package:movie_app/screen/tv_list_screen.dart';
import 'package:movie_app/utility/app_colors.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<MovieListController>().getMovieList();
      Get.find<TvListController>().getTvList();
      Get.find<HomeScreenController>().getTrendingMovies();
      Get.find<HomeScreenController>().getTopRatedMovies();
      Get.find<HomeScreenController>().getPopularMovies();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List screens = [const HomeScreen(), const MovieListScreen(), const TvListScreen()];
    return GetBuilder<BottomNavController>(
      builder: (navController) {
        return Scaffold(
          body: screens[navController.currentIndex],
          bottomNavigationBar: GNav(
            backgroundColor: Colors.transparent,
            tabActiveBorder: Border.all(color: primaryColor),
            //rippleColor: Colors.grey.shade800, // tab button ripple color when pressed
            hoverColor: Colors.grey.shade700, // tab button hover color
            haptic: true, // haptic feedback
            tabBorderRadius: 15,
            tabMargin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            curve: Curves.easeInOut, // tab animation curves
            duration: const Duration(milliseconds: 200), // tab animation duration
            gap: 8, // the tab button gap between icon and text
            color: Colors.grey[800], // unselected icon color
            activeColor: primaryColor, // selected icon and text color
            iconSize: 23, // tab button icon size
            tabBackgroundColor: primaryColor.withOpacity(0.1), // selected tab background color
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            selectedIndex: navController.currentIndex,
            onTabChange: (index) {
              navController.changeIndex(index);
            },
            tabs: [
              GButton(
                icon: navController.currentIndex == 0 ? Icons.home : Icons.home_outlined,
                text: 'Home',
              ),
              GButton(
                icon: navController.currentIndex == 1 ? Icons.movie_creation : Icons.movie_creation_outlined,
                text: 'Movies',
              ),
              GButton(
                icon: navController.currentIndex == 2 ? Icons.table_rows : Icons.table_rows_outlined,
                text: 'TV',
              ),
            ],
          ),
        );
      },
    );
  }
}
