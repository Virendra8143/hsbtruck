import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/colors.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmButtonText;
  final String cancelButtonText;
  final String iconAsset;
  final Color iconColor;
  final Color iconBackgroundColor;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final Widget? customContent;
  final bool showConfirmationQuestion;

  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.message,
    this.confirmButtonText = 'Yes',
    this.cancelButtonText = 'No',
    required this.iconAsset,
    this.iconColor = Colors.white,
    required this.iconBackgroundColor,
    required this.onConfirm,
    this.onCancel,
    this.customContent,
    this.showConfirmationQuestion = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(mediaQuery.width * 0.04),
      ),
      child: Container(
        padding: EdgeInsets.all(mediaQuery.width * 0.05),
        width: mediaQuery.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(mediaQuery.width * 0.04),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with icon and title
            Row(
              children: [
                Container(
                  height: mediaQuery.height * 0.06,
                  width: mediaQuery.width * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(mediaQuery.width * 0.03),
                    color: iconBackgroundColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(mediaQuery.width * 0.02),
                    child: SvgPicture.asset(
                      iconAsset,
                      fit: BoxFit.contain,
                      color: iconColor,
                    ),
                  ),
                ),
                SizedBox(width: mediaQuery.width * 0.02),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: mediaQuery.width * 0.06,
                      color: AppColors.secondary,
                    ),
                  ),
                ),
              ],
            ),

            // Main message
            SizedBox(height: mediaQuery.height * 0.02),
            Text(
              message,
              style: TextStyle(
                fontSize: mediaQuery.width * 0.04,
                fontWeight: FontWeight.w400,
              ),
            ),

            // Custom content if provided
            if (customContent != null) ...[
              SizedBox(height: mediaQuery.height * 0.02),
              customContent!,
            ],

            // Confirmation question (optional)
            if (showConfirmationQuestion) ...[
              SizedBox(height: mediaQuery.height * 0.02),
              Padding(
                padding: EdgeInsets.only(
                  top: mediaQuery.height * 0.01,
                  right: mediaQuery.width * 0.02,
                  bottom: mediaQuery.height * 0.01,
                ),
                child: Text(
                  'Are you sure you want to proceed with this action?',
                  style: TextStyle(
                    fontSize: mediaQuery.width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                  ),
                ),
              ),
            ],

            SizedBox(height: mediaQuery.height * 0.02),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Confirm button
                GestureDetector(
                  onTap: onConfirm,
                  child: Container(
                    height: mediaQuery.height * 0.08,
                    width: mediaQuery.width * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(mediaQuery.width * 0.03),
                      color: AppColors.primary,
                    ),
                    child: Center(
                      child: Text(
                        confirmButtonText,
                        style: TextStyle(
                          color: AppColors.background,
                          fontSize: mediaQuery.width * 0.05,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: mediaQuery.width * 0.05),

                // Cancel button
                GestureDetector(
                  onTap: onCancel ?? () => Navigator.pop(context),
                  child: Container(
                    height: mediaQuery.height * 0.08,
                    width: mediaQuery.width * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(mediaQuery.width * 0.03),
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        cancelButtonText,
                        style: TextStyle(
                          color: AppColors.text,
                          fontSize: mediaQuery.width * 0.05,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}