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
  late ShippingAddressCubit shippingAddressCubit;
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

    return WillPopScope(
      onWillPop: () async {
        final state = shippingAddressCubit.state;
        if (state is ShippingAddressesLoaded && state.shippingAddresses.isEmpty) {
          // المستخدم لم يدخل أي عنوان
          final result = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("العنوان مطلوب"),
              content: const Text("يجب عليك إضافة عنوان قبل الخروج."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false), // لا تخرج
                  child: const Text("إضافة عنوان"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true), // يسمح بالخروج
                  child: const Text("العودة للرئيسية"),
                ),
              ],
            ),
          );

          if (result == true) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/main',
                  (route) => false,
              arguments: 0, // الهوم بيج
            );
          }

          return false; // منع الرجوع التلقائي
        }

        return true; // يسمح بالرجوع إذا هناك عنوان
      },
      child: BlocListener<ShippingAddressCubit, ShippingAddressState>(
        listener: (context, state) {
          if (state is ShippingAddressesLoaded &&
              state.shippingAddresses.isEmpty &&
              !_addressSheetOpened) {

            _addressSheetOpened = true;

            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (_) => BlocProvider.value(
                  value: shippingAddressCubit,
                  child: const AddingAddressesView(),
                ),
              ),
            ).then((added) {
              _addressSheetOpened = false;
              if (added == true) {
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
                PaymentSection(),
                DeliveryMethodSection(
                  totalPrice: widget.totalPrice,
                  checkoutCubit: checkoutCubit,
                ),
                SubmitOrderButton(),
              ],
            ).allPading(16),
          ),
        ),
      ),
    );
  }
}

/*
class CheckoutView extends StatefulWidget {
  final double totalPrice;
  const CheckoutView({super.key, required this.totalPrice});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  late ShippingAddressCubit shippingAddressCubit;
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
        listener: (context, state) {
          if (state is ShippingAddressesLoaded &&
              state.shippingAddresses.isEmpty &&
              !_addressSheetOpened) {

            _addressSheetOpened = true;

            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (_) => BlocProvider.value(
                  value: shippingAddressCubit,
                  child: const AddingAddressesView(),
                ),
              ),
            ).then((added) {
              _addressSheetOpened = false; // reset
              if (added == true) {
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

*/