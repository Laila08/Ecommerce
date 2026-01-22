import 'package:flutter/material.dart';

import '../../../controllers/checkout/shipping_address/shipping_address_cubit.dart';
import '../../../extensions/app_extentions.dart';
import '../../../routes/routes.dart';

class BackButtonWidget extends StatelessWidget {
  final ShippingAddressCubit shippingAddressCubit;
  const BackButtonWidget({super.key, required this.shippingAddressCubit});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final state = shippingAddressCubit.state;
        if (state is ShippingAddressesLoaded &&
            state.shippingAddresses.isNotEmpty) {
          context.pop();
        } else {
          context.pushNamedAndRemoveUntil(
            Routes.homepage,
            arguments: 2,
            predicate: (route) => false,
          );
        }
      },
      icon: Icon(Icons.arrow_back_ios),
    );
  }
}
