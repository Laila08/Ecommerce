import 'package:flutter/material.dart';

import '../../../controllers/checkout/shipping_address/shipping_address_cubit.dart';
import '../../../utils/app_messages.dart';
import 'base_address_field .dart';

class FullNameField extends StatelessWidget {
  final ShippingAddressCubit cubit;
  const FullNameField({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BaseAddressField(
      labelText: AppMessages.fullName,
      controller: cubit.nameController,
      validator: (x) => cubit.validateName(),
      textInputAction: TextInputAction.next,
    );
  }
}
