import 'package:flutter/material.dart';
import '../../../../components/widgets/rating_widget.dart';
import '../../../../extensions/app_extentions.dart';
import '../../../../models/product_model.dart';
import '../../../../routes/routes.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_messages.dart';

class ProductCard extends StatelessWidget {
  final double width;
  final ProductModel product;

  const ProductCard({super.key, required this.width, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(Routes.productinfo, arguments: product.productId);
      },
      child: Container(
        width: width,
        height: 104,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: 16.allBorderRadius,
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withValues(alpha: 0.08),
              blurRadius: 25,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Image.asset(
                product.productImage,
                width: 104,
                height: 104,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.catType,
                      style: AppTextStyles.font16BlackWeight400,
                    ),
                    Text(
                      product.productName,
                      style: AppTextStyles.font11GrayWeight400,
                    ),
                    RatingWidget(
                      product: product,
                    ).onlyPadding(topPadding: 7, bottomPadding: 4),
                    Text(
                      "${AppMessages.dollar}${product.productPrice}",
                      style: AppTextStyles.font14blackWeight500,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ).onlyPadding(bottomPadding: 16),
    );
  }
}
