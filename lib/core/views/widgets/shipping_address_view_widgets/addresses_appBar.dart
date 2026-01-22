import 'package:flutter/material.dart';

import '../../../controllers/checkout/shipping_address/shipping_address_cubit.dart';
import '../../../extensions/app_extentions.dart';
import '../../../routes/routes.dart';
import '../../../theme/app_text_styles.dart';
import '../../../utils/app_colors.dart';

class AddressesAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double totalPrice;
  final ShippingAddressCubit shippingAddressCubit;

  const AddressesAppBar({super.key, required this.totalPrice, required this.shippingAddressCubit});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      leading: IconButton(
        onPressed: () {
          context.pushNamed(
            Routes.checkout,
            arguments: {'totalPrice': totalPrice, 'cubit': shippingAddressCubit},
          );
        },
        icon: Icon(Icons.arrow_back_ios),
      ),
      title: Text(
        "Shipping Addresses",
        style: AppTextStyles.font18BlackWeight400,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
