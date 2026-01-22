import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../controllers/checkout/shipping_address/shipping_address_cubit.dart';
import '../../../models/shipping_address.dart';

class AddressBodyCheckbox extends StatelessWidget {
  final ShippingAddressModel address;
  final ShippingAddressCubit shippingAddressCubit;

  const AddressBodyCheckbox({super.key, required this.address, required this.shippingAddressCubit});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      activeColor: AppColors.blackColor,
      controlAffinity: ListTileControlAffinity.leading,
      value: address.isDefault,
      onChanged: (newValue) {
        shippingAddressCubit.makePreferred(address);
      },
      title: Text("Use as the shipping address"),
    );
  }
}
