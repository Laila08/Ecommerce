import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import '../../../components/widgets/app_text_field.dart';
import '../../../controllers/checkout/shipping_address/shipping_address_cubit.dart';

class CountryField extends StatelessWidget {
  final ShippingAddressCubit cubit;

  const CountryField({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: cubit.countryController,
      labelText: "Country",
      readOnly: true,
      hintStyle: cubit.countryTextStyle,
      suffixIcon: const Icon(Icons.arrow_forward_ios, size: 10),
      textInputAction: TextInputAction.done,
      onChangedFunction: (x) {},
      onTap: () {
        showCountryPicker(
          context: context,
          showPhoneCode: false,
          onSelect: (Country country) => cubit.changeCountry(country),
        );
      },
      validator: (x) => cubit.validateCountry(),
    );
  }
}
