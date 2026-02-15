import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Authentication/LoginScreen.dart';
import '../Utils/Const.dart';
import '../Utils/Preference.dart';
import '../utils/colors.dart';
import 'AlertDialog.dart';
import 'SettingTash.dart';

class AdminSettings extends StatefulWidget {
  const AdminSettings({super.key});

  @override
  State<AdminSettings> createState() => _AdminSettingsState();
}

class _AdminSettingsState extends State<AdminSettings> {
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
                  Text(
                    'Admin Settings',
                    style: TextStyle(
                      fontSize: mediaQuery.width * 0.05,
                      fontWeight: FontWeight.w700,
                      color: AppColors.secondary,
                    ),
                  ),
                  SizedBox(width: mediaQuery.width * 0.08),
                ],
              ),
            ),
            SizedBox(height: mediaQuery.height * 0.05),
            
            // Settings Options
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: mediaQuery.width * 0.05),
                child: Column(
                  children: [
                    // Profile Settings
                    _buildSettingsOption(
                      icon: Icons.person,
                      title: 'Profile Settings',
                      subtitle: 'Update your profile information',
                      onTap: () {
                        // TODO: Navigate to profile settings
                        Get.snackbar('Info', 'Profile settings coming soon');
                      },
                    ),
                    
                    SizedBox(height: mediaQuery.height * 0.02),
                    
                    // App Settings
                    _buildSettingsOption(
                      icon: Icons.settings,
                      title: 'App Settings',
                      subtitle: 'Configure app preferences',
                      onTap: () {
                        // TODO: Navigate to app settings
                        Get.snackbar('Info', 'App settings coming soon');
                      },
                    ),
                    
                    SizedBox(height: mediaQuery.height * 0.02),
                    
                    // Trash Management
                    _buildSettingsOption(
                      icon: Icons.delete,
                      title: 'Trash Management',
                      subtitle: 'Manage deleted items',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SettingTash()),
                        );
                      },
                    ),
                    
                    SizedBox(height: mediaQuery.height * 0.02),
                    
                    // About
                    _buildSettingsOption(
                      icon: Icons.info,
                      title: 'About',
                      subtitle: 'App version and information',
                      onTap: () {
                        // TODO: Show about dialog
                        Get.snackbar('Info', 'About information coming soon');
                      },
                    ),
                    
                    Spacer(),
                    
                    // Logout Button
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () {
                          _showLogoutDialog(context);
                        },
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    
                    SizedBox(height: mediaQuery.height * 0.02),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.whitebg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: 24,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.secondary.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.secondary.withOpacity(0.5),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
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
                      await _performLogout(context);
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

  Future<void> _performLogout(BuildContext context) async {
    try {
      // Clear saved preferences
      await Preference.removePrefKey(KEY_TOKEN);
      await Preference.saveSharedPrefBool(KEY_LOGIN, false);

      // Close the dialog
      Navigator.of(context).pop();

      // Navigate to login screen and clear navigation stack
      Get.offAll(() => LoginScreen());

    } catch (e) {
      // Close the dialog
      Navigator.of(context).pop();

      // Show error message
      Get.snackbar('Error', 'Logout failed. Please try again.');
      print('Logout error: $e');
    }
  }
}
