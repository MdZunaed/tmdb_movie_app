import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/screen/bottom_nav_screen.dart';
import 'package:movie_app/utility/app_text_style.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool visible = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        visible = true;
      });
    })
        .then((value) => Future.delayed(const Duration(milliseconds: 1200)))
        .then((value) => Get.offAll(const BottomNavScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              alignment: visible ? Alignment.center : Alignment.centerLeft,
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeIn,
              child: visible ? Image.asset("assets/images/logo.png", height: 100, width: 100) : null,
            ),
            AnimatedContainer(
              alignment: visible ? Alignment.center : Alignment.centerRight,
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeIn,
              child: visible ? Text("MOOVI", style: appBarTextStyle.copyWith(fontSize: 35)) : null,
            ),
          ],
        ),
      ),
    );
  }
}
//rive flutter muscot: https://editor.rive.app/file/flutter-puzzle-hack-project/708490
