import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/colors.dart';
import 'Delete toast.dart';

class RestorationWarning extends StatefulWidget {
  const RestorationWarning({super.key});

  @override
  State<RestorationWarning> createState() => _RestorationWarningState();
}

class _RestorationWarningState extends State<RestorationWarning> {
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
            Row(
              children: [
                Container(
                  height: mediaQuery.height * 0.06,
                  width: mediaQuery.width * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(mediaQuery.width * 0.03),
                    color: AppColors.primary,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(mediaQuery.width * 0.02),
                    child: SvgPicture.asset(
                      'assets/images/Restore.svg',
                      fit: BoxFit.contain,
                      color: AppColors.background,
                    ),
                  ),
                ),
                SizedBox(width: mediaQuery.width * 0.03),
                Expanded(
                  child: Text(
                    'Restoration Warning',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: mediaQuery.width * 0.06,
                      color: AppColors.secondary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: mediaQuery.height * 0.02),
            Text(
              "Are you sure you want to restore this data? Restoring will make it active and accessible again in the system.",
              style: TextStyle(
                fontSize: mediaQuery.width * 0.04,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: mediaQuery.height * 0.015),
            Padding(
              padding: EdgeInsets.only(top: mediaQuery.height * 0.01, right: mediaQuery.width * 0.03, bottom: mediaQuery.height * 0.01),
              child: Text(
                'Are you sure you want to proceed with this action?',
                style: TextStyle(
                  fontSize: mediaQuery.width * 0.05,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                ),
              ),
            ),
            SizedBox(height: mediaQuery.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Future.delayed(Duration(milliseconds: 100), () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Tash();
                        },
                      );
                    });
                  },
                  child: Container(
                    height: mediaQuery.height * 0.07,
                    width: mediaQuery.width * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(mediaQuery.width * 0.03),
                      color: AppColors.primary,
                    ),
                    child: Center(
                      child: Text(
                        'Yes',
                        style: TextStyle(
                          color: AppColors.background,
                          fontSize: mediaQuery.width * 0.05,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: mediaQuery.width * 0.05),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: mediaQuery.height * 0.07,
                    width: mediaQuery.width * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(mediaQuery.width * 0.03),
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        'No',
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
