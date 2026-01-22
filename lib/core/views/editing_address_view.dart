
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerceapp/core/controllers/checkout/shipping_address/shipping_address_cubit.dart';
import 'package:ecommerceapp/core/models/shipping_address.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:ecommerceapp/core/extensions/app_extentions.dart';

import 'widgets/addresses_view_widgets/full_name_field.dart';
import 'widgets/addresses_view_widgets/address_field.dart';
import 'widgets/addresses_view_widgets/city_field.dart';
import 'widgets/addresses_view_widgets/region_field.dart';
import 'widgets/addresses_view_widgets/zip_code_field.dart';
import 'widgets/addresses_view_widgets/country_field.dart';
import 'widgets/addresses_view_widgets/save_button.dart';

class EditingAddressView extends StatefulWidget {
  final ShippingAddressModel address;
  const EditingAddressView({super.key, required this.address});

  @override
  State<EditingAddressView> createState() => _EditingAddressViewState();
}

class _EditingAddressViewState extends State<EditingAddressView> {
  late ShippingAddressCubit shippingAddressCubit;
  @override
  void initState() {
    super.initState();
    shippingAddressCubit = context.read<ShippingAddressCubit>();
    shippingAddressCubit.fillControllersFromAddress(widget.address);
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    Future<void> updateAddress() async {
      if (formKey.currentState!.validate()) {
        await shippingAddressCubit.updateShippingAddress(widget.address);
        shippingAddressCubit.clearControllers();
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Editing Shipping Address",
          style: AppTextStyles.font18BlackWeight400,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            spacing: 20,
            children: [
              FullNameField(cubit: shippingAddressCubit),
              AddressField(cubit: shippingAddressCubit),
              CityField(cubit: shippingAddressCubit),
              RegionField(cubit: shippingAddressCubit),
              ZipCodeField(cubit: shippingAddressCubit),
              CountryField(cubit: shippingAddressCubit),
              SaveButton(
                title: "EDIT ADDRESS",
                onTap: (){
                  updateAddress();
                  context.pop();
                },
              ),
            ],
          ).horizontalPadding(17).verticalPadding(40),
        ),
      ),
    );
  }
}


