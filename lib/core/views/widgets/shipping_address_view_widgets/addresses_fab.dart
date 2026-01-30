import 'package:flutter/material.dart';

import '../../../controllers/checkout/shipping_address/shipping_address_cubit.dart';
import '../../../extensions/app_extentions.dart';
import '../../../routes/routes.dart';
import '../../../utils/app_colors.dart';

class AddressesFAB extends StatelessWidget {
  final ShippingAddressCubit shippingAddressCubit;

  const AddressesFAB({super.key, required this.shippingAddressCubit});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(
          Routes.setShippingAddresses,
          arguments: shippingAddressCubit,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: 36.allBorderRadius,
          color: AppColors.blackColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              spreadRadius: 0,
              blurRadius: 4,
              color: AppColors.blackColor.withValues(alpha: 0.22),
            ),
          ],
        ),
        child: const Icon(
          Icons.add,
          color: AppColors.whiteColor,
        ).allPading(15),
      ),
    );
  }
}
