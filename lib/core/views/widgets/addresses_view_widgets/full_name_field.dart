import 'package:flutter/material.dart';

import '../../../components/widgets/app_text_field.dart';
import '../../../controllers/checkout/shipping_address/shipping_address_cubit.dart';
import '../../../theme/app_text_styles.dart';

class FullNameField extends StatelessWidget {
  final ShippingAddressCubit cubit;
  final void Function(String)? onChanged;

  const FullNameField({super.key, required this.cubit, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      hintStyle: AppTextStyles.font14GrayWeight500,
      labelText: "Full name",
      controller: cubit.nameController,
      validator: (x) => cubit.validateName(),
      textInputAction: TextInputAction.next,
      onChangedFunction: onChanged ?? (x) {},
    );
  }
}
