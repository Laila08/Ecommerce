import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/checkout/checkout_cubit.dart';
import '../../../extensions/app_extentions.dart';
import '../../../models/delivery_method_model.dart';
import '../../../theme/app_text_styles.dart';

class DeliverySummary extends StatelessWidget {
  final double totalPrice;
  final CheckoutCubit checkoutCubit;

  const DeliverySummary({
    super.key,
    required this.totalPrice,
    required this.checkoutCubit,
  });

  List<MapEntry<String, int>> deliveryInfo(DeliveryMethodModel deliveryModel) {
    return [
      MapEntry('Order:', totalPrice.toInt()),
      MapEntry('Delivery:', deliveryModel.price),
      MapEntry('Summary:', totalPrice.toInt() + deliveryModel.price),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      bloc: checkoutCubit,
      buildWhen: (previous, current) => current is DeliveryMethodLoaded,
      builder: (context, state) {
        if (state is DeliveryMethodLoaded) {
          final delivery = deliveryInfo(state.selectedMethod!);
          return Column(
            children: List.generate(delivery.length, (index) {
              final item = delivery[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.key,
                      style: item.key == 'Summary:'
                          ? AppTextStyles.font16GrayWeight400
                          : AppTextStyles.font14GrayWeight500,
                    ),
                    Text(
                      '${item.value}\$',
                      style: item.key == 'Summary:'
                          ? AppTextStyles.font18BlackWeight400
                          : AppTextStyles.font16BlackWeight400,
                    ),
                  ],
                ),
              );
            }),
          ).onlyPadding(topPadding: 40);
        }
        return SizedBox.shrink();
      },
    );
  }
}
