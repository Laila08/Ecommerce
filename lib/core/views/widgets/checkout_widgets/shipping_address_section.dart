import 'package:ecommerceapp/core/views/widgets/checkout_widgets/shipping_address_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/widgets/app_dialog.dart';
import '../../../controllers/checkout/shipping_address/shipping_address_cubit.dart';
import '../../../extensions/app_extentions.dart';
import '../../../theme/app_text_styles.dart';

class ShippingAddressSection extends StatelessWidget {
  final ShippingAddressCubit shippingAddressCubit;
  final double totalPrice;
  const ShippingAddressSection({
    super.key,
    required this.shippingAddressCubit,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Shipping address',
          style: AppTextStyles.font16BlackWeight400,
        ).onlyPadding(bottomPadding: 16),
        BlocBuilder<ShippingAddressCubit, ShippingAddressState>(
          bloc: shippingAddressCubit,
          buildWhen: (previous, current) =>
              current is AddingShippingAddress ||
              current is ShippingAddressesLoaded ||
              current is ShippingAddressAddingFailed,
          builder: (context, state) {
            if (state is AddingShippingAddress) {
              return CircularProgressIndicator().center();
            }
            if (state is ShippingAddressAddingFailed) {
              return AppDialog(message: state.error);
            }
            if (state is ShippingAddressesLoaded) {
              final defaultAddress = state.defaultAddress;
              if (defaultAddress == null) {
                return TextButton(
                  onPressed: () {},
                  child: Text("No addresses added yet"),
                );
              }
              return ShippingAddressCard(
                address: defaultAddress,
                cubit: shippingAddressCubit,
                totalPrice: totalPrice,
              );
            }
            return SizedBox.shrink();
          },
        ),
      ],
    ).onlyPadding(bottomPadding: 45);
  }
}
