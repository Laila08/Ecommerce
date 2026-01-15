import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
class CircleIconWidget extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  const CircleIconWidget({super.key, required this.icon, required this.color,this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Container(
        padding:5.allPading,
        decoration: BoxDecoration(
          boxShadow:  [
            BoxShadow(
              spreadRadius: 0,
              blurRadius: 8,
              offset: Offset(0, 4),
              color: AppColors.grayColor.withValues(alpha: 0.10),
            ),
          ],
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Icon(
          icon,
          color: color,
        ),
      ),
    );
  }
}
