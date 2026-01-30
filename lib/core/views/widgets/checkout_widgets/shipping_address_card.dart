import 'package:flutter/material.dart';

import '../../../controllers/checkout/shipping_address/shipping_address_cubit.dart';
import '../../../extensions/app_extentions.dart';
import '../../../models/shipping_address.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_text_styles.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_messages.dart';

class ShippingAddressCard extends StatelessWidget {
  final ShippingAddressModel address;
  final ShippingAddressCubit cubit;
  final double totalPrice;

  const ShippingAddressCard({
    super.key,
    required this.address,
    required this.cubit,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: 16.allBorderRadius,
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.08),
            offset: const Offset(0, 1),
            spreadRadius: 0,
            blurRadius: 25,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  address.address,
                  style: AppTextStyles.font14BlackWeight400,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  context.pushNamed(
                    Routes.shippingAddresses,
                    arguments: {'cubit': cubit, 'totalPrice': totalPrice},
                  );
                },
                child: Text(
                  AppMessages.changeButton,
                  style: AppTextStyles.font14PrimaryWeight500,
                ),
              ),
            ],
          ),
          Text(
            address.state,
            style: AppTextStyles.font14GrayWeight500,
          ).onlyPadding(bottomPadding: 10),
        ],
      ),
    );
  }
}
