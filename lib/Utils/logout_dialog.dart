import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Authentication/LoginScreen.dart';
import '../Data/AppDialoge.dart';
import 'Const.dart';
import 'Preference.dart';
import 'colors.dart'; // Assuming you use GetX for navigation


// Replace with your actual imports
 // For Preference

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.logout_rounded,
              color: Colors.red.shade600,
              size: 20,
            ),
          ),
          SizedBox(width: 12),
          Text(
            'Logout',
            style: TextStyle(
              color: AppColors.secondary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      content: Text(
        'Are you sure you want to logout?',
        style: TextStyle(
          color: AppColors.secondary.withOpacity(0.7),
          fontSize: 14,
        ),
      ),
      actions: [
        Container(
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.whitebg,
                    foregroundColor: AppColors.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: TextButton(
                  onPressed: () async {
                    await performLogout(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                    foregroundColor: AppColors.background,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Future<void> performLogout(BuildContext context) async {
  try {
    // Clear saved preferences using your Preference class
    await Preference.removePrefKey(KEY_TOKEN);
    await Preference.removePrefKey('user_name'); // Clear user name as well
    await Preference.saveSharedPrefBool(KEY_LOGIN, false);

    // Close the dialog
    // It's good practice to check if the dialog is still mounted before popping
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }

    // Show logout success message
    Appdialogs.showToast('Logged out successfully');

    // Navigate to login screen and clear navigation stack
    Get.offAll(() => LoginScreen());

  } catch (e) {
    // Close the dialog if it's still open
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }

    // Show error message
    Appdialogs.showToast('Logout failed. Please try again.');

    print('Logout error: $e');
  }
}
