import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/utils/app_colors.dart';

class ProductInfoWidget extends StatelessWidget {
  final String name;
  final String type;
  final int price;
  final int disCount;

  const ProductInfoWidget({
    super.key,
    required this.name,
    required this.type,
    required this.price,
    required this.disCount,
  });

  @override
  Widget build(BuildContext context) {
    double finalPrice = price * (1 - disCount / 100);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: AppTextStyles.font11GrayWeight400),
        Text(type, style: AppTextStyles.font16BlackWeight400),
        disCount == 0
            ? Text(
                "${price.toString()}\$",
                style: AppTextStyles.font14blackWeight500,
              )
            : Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "${price.toString()}\$ ",
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.grayColor,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    TextSpan(
                      text: " ${finalPrice.toString()}\$",
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.primaryColor,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
