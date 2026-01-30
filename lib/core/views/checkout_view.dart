import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/checkout/checkout_cubit.dart';
import '../controllers/checkout/shipping_address/shipping_address_cubit.dart';
import '../extensions/app_extentions.dart';
import '../utils/app_colors.dart';
import 'adding_addresses_view.dart';
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
  late final ShippingAddressCubit shippingAddressCubit;
  bool _addressSheetOpened = false;

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
      listenWhen: (previous, current) =>
          current is ShippingAddressesLoaded &&
          current.shippingAddresses.isEmpty,
      listener: (context, state) {
        if (state is ShippingAddressesLoaded &&
            state.shippingAddresses.isEmpty &&
            !_addressSheetOpened) {
          _addressSheetOpened = true;

          WidgetsBinding.instance.addPostFrameCallback((_) async {
            if (!mounted) return;
            final added = await Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (_) => BlocProvider.value(
                  value: shippingAddressCubit,
                  child: const AddingAddressesView(),
                ),
              ),
            );

            _addressSheetOpened = false;

            if (added == true && mounted) {
              shippingAddressCubit.getShippingAddresses();
            }
          });
        }
      },
      child: Scaffold(
        appBar: CheckoutAppBar(),
        backgroundColor: AppColors.backGroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShippingAddressSection(
                shippingAddressCubit: shippingAddressCubit,
                totalPrice: widget.totalPrice,
              ),
              const PaymentSection(),
              DeliveryMethodSection(checkoutCubit: checkoutCubit),
              SubmitOrderButton(
                amount: checkoutCubit.state is DeliveryMethodLoaded
                    ? (checkoutCubit.state as DeliveryMethodLoaded).totalAmount
                    : widget.totalPrice,
                checkoutCubit: checkoutCubit,
              ),
            ],
          ).allPading(16),
        ),
      ),
    );
  }
}
