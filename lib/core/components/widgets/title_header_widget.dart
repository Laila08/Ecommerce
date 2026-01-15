import 'package:flutter/material.dart';

import '../../extensions/app_extentions.dart';
import '../../theme/app_text_styles.dart';
class TitleHeaderWidget extends StatelessWidget {
  final String title;
  const TitleHeaderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.font34BlackWeight700,
    ).onlyPadding(leftPadding: 16, bottomPadding: 8);
  }
}
