import 'package:flutter/material.dart';
import '../utils/colors.dart';

class PasswdTextCopied extends StatelessWidget {
  const PasswdTextCopied({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(mediaQuery.width * 0.06),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        height: mediaQuery.height * 0.12,
        width: mediaQuery.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(mediaQuery.width * 0.06),
          color: AppColors.alert,
        ),
        padding: EdgeInsets.symmetric(horizontal: mediaQuery.width * 0.08),
        child: Center(
          child: Text(
            "Admin ID Password has been copied! Thank you",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: mediaQuery.width * 0.04,
              fontWeight: FontWeight.w700,
              color: AppColors.background,
            ),
          ),
        ),
      ),
    );
  }
}
