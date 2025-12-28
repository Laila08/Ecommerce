import 'package:flutter/material.dart';
import '../../../../../core/extensions/app_extentions.dart';
import '../../../../../core/utils/app_colors.dart';

class SocialWidget extends StatelessWidget {
  final String? image;
  const SocialWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: 15.allBorderRadius,
        color: AppColors.whiteColor,
      ),
      child: Image.asset(image!),
    );
  }
}
