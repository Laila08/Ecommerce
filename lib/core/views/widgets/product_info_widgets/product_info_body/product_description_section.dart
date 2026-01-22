import 'package:flutter/material.dart';

import '../../../../extensions/app_extentions.dart';
import '../../../../theme/app_text_styles.dart';

class ProductDescriptionSection extends StatelessWidget {
  final String description;

  const ProductDescriptionSection({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: AppTextStyles.font14BlackWeight400,
    ).horizontalPadding(16);
  }
}
