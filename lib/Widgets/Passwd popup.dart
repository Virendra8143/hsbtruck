import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'PasswdCopied.dart';

class PasswdPopup extends StatelessWidget {
  const PasswdPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(mediaQuery.width * 0.06),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        height: mediaQuery.height * 0.15,
        width: mediaQuery.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(mediaQuery.width * 0.06),
          color: AppColors.secondary,
        ),
        padding: EdgeInsets.symmetric(
            horizontal: mediaQuery.width * 0.05, vertical: mediaQuery.height * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Admin Name (Branch name & City)",
              style: TextStyle(
                fontSize: mediaQuery.width * 0.04,
                fontWeight: FontWeight.w700,
                color: AppColors.background,
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kundan_8346",
                        style: TextStyle(
                          fontSize: mediaQuery.width * 0.035,
                          fontWeight: FontWeight.w400,
                          color: AppColors.background,
                          decoration: TextDecoration.none,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "@136password",
                        style: TextStyle(
                          fontSize: mediaQuery.width * 0.035,
                          fontWeight: FontWeight.w400,
                          color: AppColors.background,
                          decoration: TextDecoration.none,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: mediaQuery.width * 0.03),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/images/whatsappicon.png',
                    width: mediaQuery.width * 0.06,
                    height: mediaQuery.width * 0.06,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Future.delayed(Duration(milliseconds: 100), () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const PasswdTextCopied();
                        },
                      );
                    });
                  },
                  icon: Image.asset(
                    'assets/images/Copy.png',
                    color: AppColors.background,
                    width: mediaQuery.width * 0.06,
                    height: mediaQuery.width * 0.06,
                    fit: BoxFit.fitHeight,
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
