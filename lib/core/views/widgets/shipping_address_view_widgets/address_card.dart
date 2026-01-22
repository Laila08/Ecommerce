import 'package:flutter/material.dart';

import '../../../controllers/checkout/shipping_address/shipping_address_cubit.dart';
import '../../../extensions/app_extentions.dart';
import '../../../models/shipping_address.dart';
import '../../../utils/app_colors.dart';
import 'address_body_Checkbox.dart';
import 'address_header.dart';

class AddressCard extends StatelessWidget {
  final ShippingAddressModel address;
  final ShippingAddressCubit shippingAddressCubit;

  const AddressCard({super.key, required this.address, required this.shippingAddressCubit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: 16.allPading,
      width: 343,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: 16.allBorderRadius,
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.08),
            offset: Offset(0, 1),
            spreadRadius: 0,
            blurRadius: 25,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AddressHeader(address: address),
          AddressBodyCheckbox(address: address, shippingAddressCubit: shippingAddressCubit),
        ],
      ),
    );
  }
}
