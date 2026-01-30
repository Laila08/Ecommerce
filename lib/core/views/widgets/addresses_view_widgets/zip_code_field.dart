import 'package:flutter/material.dart';
import '../../../controllers/checkout/shipping_address/shipping_address_cubit.dart';
import '../../../utils/app_messages.dart';
import 'base_address_field .dart';

class ZipCodeField extends StatelessWidget {
  final ShippingAddressCubit cubit;

  const ZipCodeField({super.key, required this.cubit,});

  @override
  Widget build(BuildContext context) {
    return BaseAddressField(
      labelText: AppMessages.zip,
      controller: cubit.zipCodeController,
      validator: (x) => cubit.validateZipCode(),
      textInputAction: TextInputAction.next,
    );
  }
}
