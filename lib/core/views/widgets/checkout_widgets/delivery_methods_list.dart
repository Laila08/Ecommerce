import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/widgets/app_dialog.dart';
import '../../../controllers/checkout/checkout_cubit.dart';
import '../../../extensions/app_extentions.dart';
import 'delivery_method_card.dart';

class DeliveryMethodsList extends StatelessWidget {
  final CheckoutCubit checkoutCubit;
  const DeliveryMethodsList({super.key, required this.checkoutCubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      bloc: checkoutCubit,
      buildWhen: (previous, current) =>
          current is DeliveryMethodLoading ||
          current is DeliveryMethodLoaded ||
          current is DeliveryMethodFailed,
      builder: (context, state) {
        if (state is DeliveryMethodLoading) {
          return CircularProgressIndicator().center();
        }
        if (state is DeliveryMethodFailed) {
          return AppDialog(message: state.error);
        }
        if (state is DeliveryMethodLoaded) {
          final deliveryMethods = state.deliveryMethods;
          return SizedBox(
            height: 72,
            child: Row(
              children: List.generate(deliveryMethods.length, (index) {
                final deliveryMethod = deliveryMethods[index];
                return Expanded(
                  child: DeliveryMethodCard(
                    deliveryMethod: deliveryMethod,
                    onTap: () =>
                        checkoutCubit.setSelectedMethode(deliveryMethod),
                    isLast: index == deliveryMethods.length - 1,
                  ),
                );
              }),
            ),
          );
        }
        return SizedBox.shrink();
      },
    ).verticalPadding(20);
  }
}
