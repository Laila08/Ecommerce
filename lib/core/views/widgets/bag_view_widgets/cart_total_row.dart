import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_text_styles.dart';

class CartTotalRow extends StatelessWidget {
  final double totalPrice;

  const CartTotalRow({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Total amount", style: AppTextStyles.font14GrayWeight500),
        const Spacer(),
        Text("$totalPrice", style: AppTextStyles.font18BlackWeight400),
      ],
    ).verticalPadding(20);
  }
}
