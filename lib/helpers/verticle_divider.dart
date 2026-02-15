import 'package:flutter/material.dart';

import '../Utils/colors.dart';


Widget verticalDivider() {
  return Container(
    height: 60,
    width: 0.8,
    color: AppColors.secondary.withOpacity(0.3),
    margin: const EdgeInsets.symmetric(horizontal: 8),
  );
}
