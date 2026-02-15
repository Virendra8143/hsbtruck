import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';
import 'ManualScreen.dart';
import 'NotificationsScreen.dart';

class CommonHeader extends StatelessWidget {
  final String? title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final bool showNotificationIcon;
  final bool showDrawerIcon;
  final bool showLogoutButton;
  final VoidCallback? onLogoutPressed;

  const CommonHeader({
    Key? key,
    this.title,
    this.showBackButton = true,
    this.onBackPressed,
    this.showNotificationIcon = true,
    this.showDrawerIcon = true,
    this.showLogoutButton = false,
    this.onLogoutPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          SizedBox(height: height * 0.02),
          // Header row
          Row(
            children: [
              // Back button (if enabled)
              if (showBackButton)
                GestureDetector(
                  onTap: onBackPressed ?? () => Get.back(),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: SvgPicture.asset(
                      'assets/images/backwithlogo.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              
              // Title (if provided)
              // if (title != null) ...[
              //   if (showBackButton) SizedBox(width: 16),
              //   Expanded(
              //     child: Text(
              //       title!,
              //       style: TextStyle(
              //         fontSize: 20,
              //         fontWeight: FontWeight.w700,
              //         color: AppColors.secondary,
              //       ),
              //       textAlign: TextAlign.center,
              //     ),
              //   ),
              // ] else
              //   Spacer(),
              Spacer(),
              // Notification icon (if enabled)
              if (showNotificationIcon)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const NotificationsScreen());
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: SvgPicture.asset(
                        'assets/images/notification.svg',

                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              
              // Spacing between notification and drawer/logout
              if (showNotificationIcon && (showDrawerIcon || showLogoutButton))
                SizedBox(width: 16),
              
              // Drawer icon (if enabled)
              if (showDrawerIcon)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ManualScreen()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: SvgPicture.asset(
                      'assets/images/drawer.svg',


                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              
              // Logout button (if enabled)
              if (showLogoutButton)
                GestureDetector(
                  onTap: onLogoutPressed,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.red.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.logout_rounded,
                      color: Colors.red.shade600,
                      size: 20,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

