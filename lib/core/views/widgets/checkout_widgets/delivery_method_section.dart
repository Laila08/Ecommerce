import 'package:flutter/material.dart';

import '../../../controllers/checkout/checkout_cubit.dart';
import '../../../extensions/app_extentions.dart';
import '../../../theme/app_text_styles.dart';
import 'delivery_methods_list.dart';
import 'delivery_summary.dart';
import '../../../utils/app_messages.dart';

class DeliveryMethodSection extends StatelessWidget {
  final CheckoutCubit checkoutCubit;

  const DeliveryMethodSection({
    super.key,
    required this.checkoutCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppMessages.deliveryMethodTitle,
          style: AppTextStyles.font16BlackWeight400,
        ).onlyPadding(bottomPadding: 7),
        DeliveryMethodsList(checkoutCubit: checkoutCubit),
        DeliverySummary(checkoutCubit: checkoutCubit),
      ],
    );
  }
}
