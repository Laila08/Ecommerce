import 'package:flutter/material.dart';

import '../../../../theme/app_text_styles.dart';

class ProductAttributes extends StatelessWidget {
  final String color;
  final String size;

  const ProductAttributes({super.key, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: "Color: ", style: AppTextStyles.font11GrayWeight400),
          TextSpan(text: color, style: AppTextStyles.font11BlackWeight400),
          TextSpan(text: "  Size: ", style: AppTextStyles.font11GrayWeight400),
          TextSpan(text: size, style: AppTextStyles.font11BlackWeight400),
        ],
      ),
    );
  }
}
