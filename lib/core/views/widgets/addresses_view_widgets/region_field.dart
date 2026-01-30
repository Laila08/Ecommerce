import 'package:flutter/material.dart';
import '../../../controllers/checkout/shipping_address/shipping_address_cubit.dart';
import '../../../utils/app_messages.dart';
import 'base_address_field .dart';

class RegionField extends StatelessWidget {
  final ShippingAddressCubit cubit;

  const RegionField({super.key, required this.cubit,});

  @override
  Widget build(BuildContext context) {
    return BaseAddressField(
      labelText: AppMessages.region,
      controller: cubit.regionController,
      validator: (x) => cubit.validateRegion(),
      textInputAction: TextInputAction.next,
    );
  }
}
