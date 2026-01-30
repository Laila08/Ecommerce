import 'package:flutter/material.dart';

import '../../../extensions/app_extentions.dart';
import '../../../theme/app_text_styles.dart';
import '../../../utils/app_messages.dart';

class PaymentSection extends StatelessWidget {
  const PaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              AppMessages.paymentTitle,
              style: AppTextStyles.font16BlackWeight400,
            ).onlyPadding(bottomPadding: 16),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: Text(
                AppMessages.changeButton,
                style: AppTextStyles.font14PrimaryWeight500,
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(borderRadius: 16.allBorderRadius),
          child: Image.asset("assets/images/mastercard.png", fit: BoxFit.cover),
        ),
      ],
    ).onlyPadding(bottomPadding: 45);
  }
}
