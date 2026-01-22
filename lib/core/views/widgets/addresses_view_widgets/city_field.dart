import 'package:flutter/material.dart';

import '../../../components/widgets/app_text_field.dart';
import '../../../controllers/checkout/shipping_address/shipping_address_cubit.dart';
import '../../../theme/app_text_styles.dart';

class CityField extends StatelessWidget {
  final ShippingAddressCubit cubit;
  final void Function(String)? onChanged;

  const CityField({super.key, required this.cubit, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      hintStyle: AppTextStyles.font14GrayWeight500,
      labelText: "City",
      controller: cubit.cityController,
      validator: (x) => cubit.validateCity(),
      textInputAction: TextInputAction.next,
      onChangedFunction: onChanged ?? (x) {},
    );
  }
}
