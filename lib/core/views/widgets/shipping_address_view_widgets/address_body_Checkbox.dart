import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/checkout/shipping_address/shipping_address_cubit.dart';
import '../../../models/shipping_address.dart';
import '../../../utils/app_messages.dart';

class AddressBodyCheckbox extends StatelessWidget {
  final ShippingAddressModel address;
  final ShippingAddressCubit shippingAddressCubit;

  const AddressBodyCheckbox({
    super.key,
    required this.address,
    required this.shippingAddressCubit,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShippingAddressCubit, ShippingAddressState>(
      bloc: shippingAddressCubit,
      buildWhen: (previous, current) =>
      current is MakingPreferred ||
          current is PreferredMade ||
          current is ShippingAddressesLoaded,
      builder: (context, state) {
        final bool isAnyLoading = state is MakingPreferred;
        final bool isThisLoading =
            state is MakingPreferred && state.addressId == address.id;

        return CheckboxListTile(
          activeColor: AppColors.blackColor,
          controlAffinity: ListTileControlAffinity.leading,
          value: address.isDefault,
          onChanged: isAnyLoading
              ? null
              : (_) {
            shippingAddressCubit.makePreferred(address);
          },
          title: Row(
            children: [
              Text(AppMessages.useAsShippingAddress),
              const SizedBox(width: 8),
              if (isThisLoading)
                const SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
            ],
          ),
        );
      },
    );
  }
}