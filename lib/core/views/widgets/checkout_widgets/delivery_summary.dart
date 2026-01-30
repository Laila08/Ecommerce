import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/checkout/checkout_cubit.dart';
import '../../../extensions/app_extentions.dart';
import '../../../theme/app_text_styles.dart';
import '../../../utils/app_messages.dart';

class DeliverySummary extends StatelessWidget {
  final CheckoutCubit checkoutCubit;

  const DeliverySummary({
    super.key,
    required this.checkoutCubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      bloc: checkoutCubit,
      buildWhen: (previous, current) => current is DeliveryMethodLoaded,
      builder: (context, state) {
        if (state is DeliveryMethodLoaded && state.selectedMethod != null) {
          final totalAmount = state.totalAmount;
          final deliveryPrice = state.selectedMethod!.price;
          final orderPrice = state.orderPrice;

          final delivery = [
            MapEntry(AppMessages.orderTitle, orderPrice.toInt()),
            MapEntry(AppMessages.deliveryTitle, deliveryPrice),
            MapEntry(AppMessages.summaryTitle, totalAmount.toInt()),
          ];

          return Column(
            children: List.generate(delivery.length, (index) {
              final item = delivery[index];
              final isSummary = item.key == AppMessages.totalAmount;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.key,
                      style: isSummary
                          ? AppTextStyles.font16GrayWeight400
                          : AppTextStyles.font14GrayWeight500,
                    ),
                    Text(
                      '${item.value}${AppMessages.dollar}',
                      style: isSummary
                          ? AppTextStyles.font18BlackWeight400
                          : AppTextStyles.font16BlackWeight400,
                    ),
                  ],
                ),
              );
            }),
          ).onlyPadding(topPadding: 40);
        }

        return const SizedBox.shrink();
      },
    );
  }
}
