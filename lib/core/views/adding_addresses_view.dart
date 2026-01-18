import 'package:ecommerceapp/core/components/widgets/app_text_field.dart';
import 'package:ecommerceapp/core/components/widgets/main_button.dart';
import 'package:ecommerceapp/core/controllers/checkout/shipping_address/shipping_address_cubit.dart';
import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/models/shipping_address.dart';
import 'package:ecommerceapp/core/routes/routes.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/constants.dart';
class AddingAddressesView extends StatelessWidget {
  const AddingAddressesView({super.key});
  @override
  Widget build(BuildContext context) {
    final shippingAddressCubit = context.read<ShippingAddressCubit>();
    final formKey = GlobalKey<FormState>();
   // ShippingAddressModel address;
    Future<void> saveAddress(ShippingAddressCubit shippingAddressCubit) async {
      if (formKey.currentState!.validate()) {
        final address = ShippingAddressModel(
          id: documentidFromLocalData(),
          fullName: shippingAddressCubit.nameController.text,
          country: shippingAddressCubit.countryController.text,
          address: shippingAddressCubit.addressController.text,
          city: shippingAddressCubit.cityController.text,
          state: shippingAddressCubit.regionController.text,
          zipCode: shippingAddressCubit.zipCodeController.text,
        isDefault: true);
        await shippingAddressCubit.setShippingAddresses(address);
      }
    }
    return BlocListener<ShippingAddressCubit, ShippingAddressState>(
      listener: (context, state) {
        if(state is ShippingAddressAddedSuccessfully){
          context.popUntil((route) => route.settings.name == Routes.checkout,);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          leading: IconButton(onPressed:(){
            final state = shippingAddressCubit.state;
            if (state is ShippingAddressesLoaded && state.shippingAddresses.isNotEmpty) {
              context.pushNamed(Routes.shippingAddresses, arguments: shippingAddressCubit);
            } else {
              context.pushNamedAndRemoveUntil(
                Routes.homepage,
                arguments: 2,
                predicate: (route) => false,
              );
            }
          }, icon: Icon(Icons.arrow_back_ios,)),
          title: Text(
            "Adding Shipping Address",
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
                AppTextField(
                  hintStyle: AppTextStyles.font14GrayWeight500,
                  labelText: "Full name",
                  validator: (x) => shippingAddressCubit.validateName(),
                  controller: shippingAddressCubit.nameController,
                  textInputAction: TextInputAction.next,
                  onChangedFunction: (x) {},
                ),
                AppTextField(
                  controller: shippingAddressCubit.addressController,
                  hintStyle: AppTextStyles.font14GrayWeight500,
                  labelText: "Address",
                  validator: (x) => shippingAddressCubit.validateAddress(),
                  textInputAction: TextInputAction.next,
                  onChangedFunction: (x) {},
                ),
                AppTextField(
                  controller: shippingAddressCubit.cityController,
                  hintStyle: AppTextStyles.font14GrayWeight500,
                  labelText: "City",
                  validator: (x) => shippingAddressCubit.validateCity(),
                  textInputAction: TextInputAction.next,
                  onChangedFunction: (x) {},
                ),
                AppTextField(
                  controller: shippingAddressCubit.regionController,
                  hintStyle: AppTextStyles.font14GrayWeight500,
                  labelText: "State/Province/Region",
                  validator: (x) => shippingAddressCubit.validateRegion(),
                  textInputAction: TextInputAction.next,
                  onChangedFunction: (x) {},
                ),
                AppTextField(
                  controller: shippingAddressCubit.zipCodeController,
                  hintStyle: AppTextStyles.font14GrayWeight500,
                  labelText: "Zip Code (Postal Code)",
                  validator: (x) => shippingAddressCubit.validateZipCode(),
                  textInputAction: TextInputAction.next,
                  onChangedFunction: (x) {},
                ),
                AppTextField(
                  controller: shippingAddressCubit.countryController,
                  hintStyle: AppTextStyles.font14GrayWeight500,
                  labelText: "Country",
                  validator: (x) => shippingAddressCubit.validateCountry(),
                  textInputAction: TextInputAction.done,
                  onChangedFunction: (String value) {},
                ),
                MainButton(
                    title: "SAVE ADDRESS",
                    onTap: () {
                      saveAddress(shippingAddressCubit);
                    }
                ).onlyPadding(topPadding: 20),
              ],
            ).horizontalPadding(17).verticalPadding(40),
          ),
        ),
      ),
    );
  }
}
