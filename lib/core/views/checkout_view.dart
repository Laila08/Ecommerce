import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/checkout/checkout_cubit.dart';
import '../controllers/checkout/shipping_address/shipping_address_cubit.dart';
import '../extensions/app_extentions.dart';
import '../routes/routes.dart';
import '../utils/app_colors.dart';
import 'widgets/checkout_widgets/checkout_app_bar.dart';
import 'widgets/checkout_widgets/delivery_method_section.dart';
import 'widgets/checkout_widgets/payment_section.dart';
import 'widgets/checkout_widgets/shipping_address_section.dart';
import 'widgets/checkout_widgets/submit_order_button.dart';
import 'package:flutter/material.dart';

class CheckoutView extends StatefulWidget {
  final double totalPrice;
  const CheckoutView({super.key, required this.totalPrice});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  late ShippingAddressCubit shippingAddressCubit;

  @override
  void initState() {
    super.initState();
    shippingAddressCubit = context.read<ShippingAddressCubit>();
    shippingAddressCubit.getShippingAddresses();
  }
  @override
  Widget build(BuildContext context) {
    final checkoutCubit = context.read<CheckoutCubit>();
    return BlocListener<ShippingAddressCubit, ShippingAddressState>(
      listener: (context, state) {
        if (state is ShippingAddressesLoaded && state.shippingAddresses.isEmpty) {
          context.pushNamed(
            Routes.setShippingAddresses,
            arguments: shippingAddressCubit,
          );
        }
      },
      child: Scaffold(
        appBar: CheckoutAppBar(),
        backgroundColor: AppColors.backGroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShippingAddressSection(shippingAddressCubit: shippingAddressCubit,totalPrice:widget.totalPrice),
              PaymentSection(),
              DeliveryMethodSection(totalPrice: widget.totalPrice, checkoutCubit: checkoutCubit),
              SubmitOrderButton(),
            ],
          ).allPading(16),
        ),
      ),
    );
  }
}

