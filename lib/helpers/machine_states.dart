// Helper Widget
import 'package:flutter/material.dart';

import '../Utils/colors.dart';

Widget buildStatRow(String label, String count) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: TextStyle(
          color: AppColors.background,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
      Text(
        count,
        style: TextStyle(
          color: AppColors.background,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );
}