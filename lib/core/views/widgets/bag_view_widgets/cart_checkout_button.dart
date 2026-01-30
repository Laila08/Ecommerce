import 'package:ecommerceapp/core/controllers/checkout/shipping_address/shipping_address_cubit.dart';
import 'package:ecommerceapp/core/utils/app_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/widgets/main_button.dart';
import '../../../extensions/app_extentions.dart';
import '../../../routes/routes.dart';

class CartCheckoutButton extends StatelessWidget {
  final double totalPrice;
  const CartCheckoutButton({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    final ShippingAddressCubit cubit = context.read<ShippingAddressCubit>();
    return MainButton(
      title: AppMessages.addAddressesButton,
      onTap: () => context.pushNamed(
        Routes.checkout,
        arguments: {'totalPrice': totalPrice, 'cubit': cubit},
      ),
    ).onlyPadding(bottomPadding: 20);
  }
}
