import 'package:flutter/material.dart';

import '../../../../theme/app_text_styles.dart';

class ProductName extends StatelessWidget {
  final String name;

  const ProductName({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(name, style: AppTextStyles.font16BlackWeight400);
  }
}
