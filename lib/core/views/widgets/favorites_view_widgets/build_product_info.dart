import 'package:flutter/material.dart';

import '../../../models/product_model.dart';
import '../../../theme/app_text_styles.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_messages.dart';

class BuildProductInfo extends StatelessWidget {
  final double finalPrice;
  final int discount;
  final ProductModel product;

  const BuildProductInfo({super.key, required this.finalPrice, required this.discount, required this.product});

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(product.productCategory, style: AppTextStyles.font11GrayWeight400),
        Text(product.productName, style: AppTextStyles.font16BlackWeight400),
        const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: AppMessages.color,
                style: AppTextStyles.font11GrayWeight400,
              ),
              TextSpan(text: "_   ", style: AppTextStyles.font11BlackWeight400),
              TextSpan(
                text: "         ${AppMessages.size}",
                style: AppTextStyles.font11GrayWeight400,
              ),
              TextSpan(text: "_", style: AppTextStyles.font11BlackWeight400),
            ],
          ),
        ),
        discount == 0
            ? Text(
                "${product.productPrice}${AppMessages.dollar}",
                style: AppTextStyles.font14blackWeight500,
              )
            : Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "${product.productPrice}${AppMessages.dollar} ",
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.grayColor,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    TextSpan(
                      text: " $finalPrice${AppMessages.dollar}",
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
