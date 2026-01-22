import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:flutter/material.dart';

import '../../theme/app_text_styles.dart';

class AppHeader extends StatelessWidget {
  final String title;
  const AppHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.centerRight,
          child: Icon(Icons.search, color: Colors.black, size: 25),
        ).onlyPadding(bottomPadding: 25,topPadding: 17,rightPadding: 17),
        Text(title, style: AppTextStyles.font34BlackWeight700),
      ],
    ).onlyPadding(topPadding: 17,leftPadding: 17);
  }
}
