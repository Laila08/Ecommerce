import 'package:ecommerceapp/core/utils/app_assets.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_messages.dart';

class HomeHeaderWidget extends StatelessWidget {
  final double width;
  const HomeHeaderWidget({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      width: width,
      height: 196,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(AppAssets.mainHeaderImg),
        ),
      ),
      child: Text(
        AppMessages.streetClothes,
        style: AppTextStyles.font34WhiteWeight900,
      ),
    );
  }
}
