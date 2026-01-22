import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:flutter/material.dart';
class ProductBadgeWidget extends StatelessWidget {
   final String title;
   final Color color;
   final TextStyle textStyle;
  const ProductBadgeWidget({super.key, required this.title, required this.color, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8,
      left: 10,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: 16.allBorderRadius,
        ),
        child: Text(title, style: textStyle).onlyPadding(
          topPadding: 5,
          leftPadding: 8,
          rightPadding: 8,
          bottomPadding: 5,
        ),
      ),
    );
  }
}
