
import 'package:flutter/material.dart';

import '../../../extensions/app_extentions.dart';
import '../../../theme/app_text_styles.dart';

class CategoryText extends StatelessWidget {
  final String catName;
  const CategoryText({super.key, required this.catName});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        catName,
        style: AppTextStyles.font18BlackWeight400,
      ).onlyPadding(leftPadding: 15),
    );
  }
}