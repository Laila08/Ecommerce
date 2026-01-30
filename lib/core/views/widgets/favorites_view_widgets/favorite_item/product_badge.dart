import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/widgets/product_badge_widget.dart';
import '../../../../controllers/home/home_cubit.dart';
import '../../../../models/product_model.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_messages.dart';

class ProductBadge extends StatelessWidget {
  final ProductModel product;

  const ProductBadge({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        bool isHaveDiscount = false;
        bool isNew = false;

        if (state is HomeSuccess) {
          isHaveDiscount = state.salesProducts.any(
            (p) =>
                p.productId == product.productId &&
                (p.productDiscount ?? 0) > 0,
          );
          if (!isHaveDiscount) {
            isNew = state.newProducts.any(
              (p) => p.productId == product.productId,
            );
          }
        }

        if (isHaveDiscount) {
          return ProductBadgeWidget(
            title: "${product.productDiscount}${AppMessages.percent}",
            color: AppColors.primaryColor,
            textStyle: AppTextStyles.font11WhiteWeight400,
          );
        } else if (isNew) {
          return ProductBadgeWidget(
            title: AppMessages.newText,
            color: AppColors.blackColor,
            textStyle: AppTextStyles.font11WhiteWeight400,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
