import 'package:flutter/material.dart';

import '../../../controllers/checkout/shipping_address/shipping_address_cubit.dart';
import '../../../theme/app_text_styles.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_messages.dart';

class AddressesAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double totalPrice;
  final ShippingAddressCubit shippingAddressCubit;

  const AddressesAppBar({
    super.key,
    required this.totalPrice,
    required this.shippingAddressCubit,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios),
      ),
      title: Text(
        AppMessages.shippingAddresses,
        style: AppTextStyles.font18BlackWeight400,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
