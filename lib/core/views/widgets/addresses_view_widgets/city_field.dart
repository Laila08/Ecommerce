import 'package:flutter/material.dart';
import '../../../controllers/checkout/shipping_address/shipping_address_cubit.dart';
import '../../../utils/app_messages.dart';
import 'base_address_field .dart';

class CityField extends StatelessWidget {
  final ShippingAddressCubit cubit;

  const CityField({super.key, required this.cubit,});

  @override
  Widget build(BuildContext context) {
    return BaseAddressField(
      labelText: AppMessages.city,
      controller: cubit.cityController,
      validator: (x) => cubit.validateCity(),
      textInputAction: TextInputAction.next,
    );
  }
}
