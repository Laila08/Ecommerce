import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/utils/app_messages.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_text_styles.dart';

class CartTotalRow extends StatelessWidget {
  final double totalPrice;

  const CartTotalRow({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(AppMessages.totalAmount, style: AppTextStyles.font14GrayWeight500),
        const Spacer(),
        Text(
          "${AppMessages.dollar}$totalPrice",
          style: AppTextStyles.font18BlackWeight400,
        ),
      ],
    ).verticalPadding(20);
  }
}
