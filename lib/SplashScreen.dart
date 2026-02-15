import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Authentication/LoginScreen.dart';
import 'Screens/Admin/AdminDashboard.dart';
import 'Utils/Const.dart';
import 'Utils/colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    sharedPref();
    // TODO: implement initState
    super.initState();
  }

  sharedPref() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();

    var isLoggedIn = await sharedPref.getBool(KEY_LOGIN);
    // var appinstalled = await sharedPref.getBool(KEY_SAVE_INTRO_INFO);

    Timer(Duration(seconds: 3), () {
      // if (appinstalled != null) {
      //   if (appinstalled) {
      if (isLoggedIn != null) {
        if (isLoggedIn) {
          Get.offAll(AdminDashBoard());
        } else {
          Get.offAll(LoginScreen());
        }
      } else {
        Get.offAll(LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Future.delayed(Duration(seconds: 3), () {
    //     Get.offAll(LoginScreen());
    //   });
    // });

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            color: AppColors.background,
          ),
          // Centered Logo
          Center(
            child: SvgPicture.asset(
              'assets/images/HSB.svg',
              width: size.width * 0.7,
              height: size.height * 0.15,
            ),
          ),
          // Text at the Bottom
          Positioned(
            bottom: size.height * 0.05,
            left: size.width * 0.05,
            right: size.width * 0.05,
            child: Column(
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'All Rights Reserved By ',
                        style: TextStyle(
                            fontSize: size.width * 0.04, color: AppColors.text),
                      ),
                      TextSpan(
                        text: 'HSB Fuels\n',
                        style: TextStyle(
                            fontSize: size.width * 0.04,
                            fontWeight: FontWeight.w700,
                            color: AppColors.text),
                      ),
                      TextSpan(
                        text: 'Developed by ',
                        style: TextStyle(
                            fontSize: size.width * 0.04, color: AppColors.text),
                      ),
                      TextSpan(
                        text: 'Bugsbon ',
                        style: TextStyle(
                            fontSize: size.width * 0.04,
                            fontWeight: FontWeight.w700,
                            color: AppColors.text),
                      ),
                      TextSpan(
                        text: 'for HSB Fuels ',
                        style: TextStyle(
                            fontSize: size.width * 0.04, color: AppColors.text),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
