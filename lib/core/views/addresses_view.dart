import 'package:ecommerceapp/core/components/widgets/arrow_back_icon.dart';
import 'package:ecommerceapp/core/controllers/checkout/checkout_cubit.dart';
import 'package:ecommerceapp/core/controllers/checkout/shipping_address/shipping_address_cubit.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/widgets/app_dialog.dart';
import '../extensions/app_extentions.dart';
import '../routes/routes.dart';
import '../theme/app_text_styles.dart';

class AddressesView extends StatelessWidget {
  const AddressesView({super.key});

  @override
  Widget build(BuildContext context) {
    final shippingAddressCubit = BlocProvider.of<ShippingAddressCubit>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      shippingAddressCubit.getShippingAddresses();
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leading: IconButton(
          onPressed: () {
            context.pushNamed(Routes.checkout, arguments: 0.0);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Shipping Addresses",
          style: AppTextStyles.font18BlackWeight400,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ShippingAddressCubit, ShippingAddressState>(
        bloc: shippingAddressCubit,
        buildWhen: (previous, current) =>
            current is AddingShippingAddress ||
            current is ShippingAddressesLoaded ||
            current is ShippingAddressAddingFailed,
        builder: (context, state) {
          if (state is AddingShippingAddress) {
            return CircularProgressIndicator().center();
          } else if (state is ShippingAddressAddingFailed) {
            return AppDialog(message: state.error);
          } else if (state is ShippingAddressesLoaded) {
            final shippingAddresses = state.shippingAddresses;
            return ListView.builder(
              itemCount: shippingAddresses.length,
              itemBuilder: (context, index) {
                final address = shippingAddresses[index];
                return Container(
                  margin: 16.allPading,
                  width: 343,
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: 16.allBorderRadius,
                    color: AppColors.whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.blackColor.withValues(alpha: 0.08),
                        offset: Offset(0, 1),
                        spreadRadius: 0,
                        blurRadius: 25,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(address.fullName),
                              Spacer(),
                              Text(
                                "Edit",
                                style: AppTextStyles.font14PrimaryWeight500,
                              ),
                            ],
                          ),
                          Text(address.address).onlyPadding(bottomPadding: 10),
                        ],
                      ).onlyPadding(leftPadding: 28,rightPadding: 28,topPadding:16 ),
                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        value: address.isDefault,
                        onChanged: (newValue) {
                          shippingAddressCubit.makePreferred(address);
                        },
                        title:Text("Use as the shipping address"),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.blackColor,
        child: Icon(Icons.add),
        onPressed: () {
          context.pushNamed(
            Routes.setShippingAddresses,
            arguments: shippingAddressCubit,
          );
        },
      ),
    );
  }
}
