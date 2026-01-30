import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import '../../../controllers/checkout/shipping_address/shipping_address_cubit.dart';
import '../../../utils/app_messages.dart';
import 'base_address_field .dart';

class CountryField extends StatelessWidget {
  final ShippingAddressCubit cubit;

  const CountryField({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BaseAddressField(
      labelText: AppMessages.country,
      controller: cubit.countryController,
      validator: (x) => cubit.validateCountry(),
      textInputAction: TextInputAction.done,
      readOnly: true,
      suffixIcon: const Icon(Icons.arrow_forward_ios, size: 10),
        onTap: () {
          showCountryPicker(
            context: context,
            showPhoneCode: false,
            onSelect: (Country country) {
              cubit.changeCountry(country);
              Form.of(context).validate();
            },
          );
        }
    );
  }
}
