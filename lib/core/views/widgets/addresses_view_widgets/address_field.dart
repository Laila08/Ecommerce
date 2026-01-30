import 'package:flutter/material.dart';
import '../../../controllers/checkout/shipping_address/shipping_address_cubit.dart';
import '../../../utils/app_messages.dart';
import 'base_address_field .dart';

class AddressField extends StatelessWidget {
  final ShippingAddressCubit cubit;

  const AddressField({super.key, required this.cubit,});

  @override
  Widget build(BuildContext context) {
    return BaseAddressField(
      labelText: AppMessages.address,
      controller: cubit.addressController,
      validator: (x) => cubit.validateAddress(),
      textInputAction: TextInputAction.next,
    );
  }
}
