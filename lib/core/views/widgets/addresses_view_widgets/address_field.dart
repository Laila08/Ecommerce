import 'package:flutter/material.dart';

import '../../../components/widgets/app_text_field.dart';
import '../../../controllers/checkout/shipping_address/shipping_address_cubit.dart';
import '../../../theme/app_text_styles.dart';

class AddressField extends StatelessWidget {
  final ShippingAddressCubit cubit;
  final void Function(String)? onChanged;

  const AddressField({super.key, required this.cubit, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      hintStyle: AppTextStyles.font14GrayWeight500,
      labelText: "Address",
      controller: cubit.addressController,
      validator: (x) => cubit.validateAddress(),
      textInputAction: TextInputAction.next,
      onChangedFunction: onChanged ?? (x) {},
    );
  }
}
