import 'package:ecommerceapp/core/components/widgets/app_dialog.dart';
import 'package:ecommerceapp/core/components/widgets/arrow_back_icon.dart';
import 'package:ecommerceapp/core/components/widgets/main_button.dart';
import 'package:ecommerceapp/core/controllers/checkout/checkout_cubit.dart';
import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/models/delivery_method_model.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutView extends StatelessWidget {
  final double totalPrice;
  const CheckoutView({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    List<MapEntry<String, int>> deliveryInfo(
      DeliveryMethodModel deliveryModel,
    ) {
      return [
        MapEntry('Order:', totalPrice.toInt()),
        MapEntry('Delivery:', deliveryModel.price),
        MapEntry('Summary:', totalPrice.toInt() + deliveryModel.price),
      ];
    }

    final checkoutCubit = context.read<CheckoutCubit>();
    return Scaffold(
      appBar: AppBar(
        leading: ArrowBackIcon(),
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        title: Text("Checkout", style: AppTextStyles.font18BlackWeight400),
      ),
      backgroundColor: AppColors.backGroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shipping address',
                style: AppTextStyles.font16BlackWeight400,
              ).onlyPadding(bottomPadding: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
                    Row(
                      children: [
                        Text("Jane Doe"),
                        Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Change",
                            style: AppTextStyles.font14PrimaryWeight500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "3 Newbridge Court \nChino Hills, CA 91709, United States",
                    ).onlyPadding(bottomPadding: 10),
                  ],
                ),
              ),
            ],
          ).onlyPadding(bottomPadding: 45),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Payment',
                    style: AppTextStyles.font16BlackWeight400,
                  ).onlyPadding(bottomPadding: 16),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Change",
                      style: AppTextStyles.font14PrimaryWeight500,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(borderRadius: 16.allBorderRadius),
                    child: Image.asset(
                      "assets/images/mastercard.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ],
          ).onlyPadding(bottomPadding: 45),
        Text(
              'Delivery method',
              style: AppTextStyles.font16BlackWeight400,
            ).onlyPadding(bottomPadding: 7),

          BlocBuilder<CheckoutCubit, CheckoutState>(
            bloc: checkoutCubit,
            buildWhen: (previous, current) =>
                current is CheckoutLoading ||
                current is CheckoutFailed ||
                current is CheckoutLoaded,
            builder: (context, state) {
              if (state is CheckoutLoading) {
                return CircularProgressIndicator().center();
              } else if (state is CheckoutFailed) {
                return AppDialog(message: state.error);
              } else if (state is CheckoutLoaded) {
                final deliveryMethods = state.deliveryMethods;
                final delivery = deliveryInfo(state.selectedMethod!);
                return Column(
                  children: [
                    SizedBox(
                      height: 72,
                      child: Row(
                        children: List.generate(deliveryMethods.length, (
                          index,
                        ) {
                          final deliveryMethod = deliveryMethods[index];
                          return Expanded(
                            child: InkWell(
                              onTap: () {
                                checkoutCubit.setSelectedMethode(deliveryMethod);
                              },
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              child: Container(
                                margin: EdgeInsets.only(
                                  right: index == deliveryMethods.length - 1
                                      ? 0
                                      : 16,
                                ),
                                padding: 10.allPading,
                                height: 72,
                                decoration: BoxDecoration(
                                  borderRadius: 16.allBorderRadius,
                                  color: AppColors.whiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.blackColor.withValues(
                                        alpha: 0.08,
                                      ),
                                      blurRadius: 25,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(deliveryMethod.imgUrl),
                                    Text(
                                      deliveryMethod.days,
                                      style: AppTextStyles.font11GrayWeight400,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    Column(
                      children: List.generate(delivery.length, (index) {
                        final item = delivery[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.key,
                                style: item.key=='Summary:'?AppTextStyles.font16GrayWeight400:AppTextStyles.font14GrayWeight500,
                              ),
                              Text(
                                '${item.value}\$',
                                style: item.key=='Summary:'?AppTextStyles.font18BlackWeight400:AppTextStyles.font16BlackWeight400,
                              ),
                            ],
                          ),
                        );
                      }),
                    ).onlyPadding(topPadding: 40),
                  ],
                );
              }
              return SizedBox.shrink();
            },
          ).verticalPadding(20),
          MainButton(title: "SUBMIT ORDER"),
        ],
      ).allPading(16),
    );
  }
}
