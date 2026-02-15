import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Authentication/LoginScreen.dart';
import '../utils/colors.dart';
// import 'AdminSettings.dart';
import 'SettingTash.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: mediaQuery.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mediaQuery.width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      'assets/images/backwithlogo.svg',
                      width: mediaQuery.width * 0.25,
                      height: mediaQuery.height * 0.06,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/images/Settingback.png',
                      width: mediaQuery.width * 0.08,
                      height: mediaQuery.height * 0.06,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: mediaQuery.height * 0.05),
            Row(
              children: [
                GestureDetector(
                  child: Column(
                    children: [
                      Text(
                        "Settings",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: mediaQuery.width * 0.05,
                          color: AppColors.secondary,
                        ),
                      ),
                      SizedBox(height: mediaQuery.height * 0.005),
                      Padding(
                        padding: EdgeInsets.only(left: mediaQuery.width * 0.05),
                        child: Container(
                          height: mediaQuery.height * 0.002,
                          width: mediaQuery.width * 0.3,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: mediaQuery.height * 0.03),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingTash()),
                );
              },
              child: Container(
                height: mediaQuery.height * 0.1,
                width: mediaQuery.width * 0.9,
                decoration: BoxDecoration(
                  color: AppColors.whitebg,
                  borderRadius: BorderRadius.circular(mediaQuery.width * 0.03),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: mediaQuery.width * 0.05),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Delete.svg',
                        color: AppColors.secondary,
                        width: mediaQuery.width * 0.06,
                        height: mediaQuery.height * 0.03,
                      ),
                      SizedBox(width: mediaQuery.width * 0.05),
                      Text(
                        'Trashed Item (4)',
                        style: TextStyle(fontSize: mediaQuery.width * 0.04, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: mediaQuery.height * 0.03),
            Padding(
              padding: EdgeInsets.only(left: mediaQuery.width * 0.08),
              child: Row(
                children: [
                  Text(
                    'Log Out',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: mediaQuery.width * 0.05,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(width: mediaQuery.width * 0.03),
                  GestureDetector(
                    onTap: (){
                      Get.to(LoginScreen());
                    },
                    child: SvgPicture.asset(
                      'assets/images/logout.svg',
                      width: mediaQuery.width * 0.06,
                      height: mediaQuery.height * 0.03,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
