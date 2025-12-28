import 'package:ecommerceapp/core/components/widgets/arrow_back_icon.dart';
import 'package:ecommerceapp/core/components/widgets/favorite_icon_widget.dart';
import 'package:ecommerceapp/core/components/widgets/main_button.dart';
import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:ecommerceapp/features/auth/presentation/views/widgets/rating_widget.dart';
import 'package:ecommerceapp/features/auth/presentation/views/widgets/text_header_widget.dart';
import 'package:ecommerceapp/product_model.dart';
import 'package:flutter/material.dart';

class ProductInfoView extends StatelessWidget {
  final ProductModel product;
  const ProductInfoView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Widget bottomNavigationBar(){
      return Container(
        height: 78,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withValues(alpha: 0.10),
              blurRadius: 8,
              spreadRadius: 0,
              offset: Offset(0, -4),
            ),
          ],
        ),
        padding: 16.allPading,
        child: MainButton(title: "ADD TO CART"),
      );
    }
    final height = context.heigh;
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        title: Text("Short dress", style: AppTextStyles.font18BlackWeight400),
        centerTitle: true,
        leading: ArrowBackIcon().onlyPadding(leftPadding: 16),
        actions: [
          Icon(
            Icons.share,
            color: AppColors.blackColor,
          ).onlyPadding(rightPadding: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              product.productImage,
              height: height * 0.64,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Row(
              children: [Spacer(), FavoriteIconWidget()],
            ).onlyPadding(topPadding: 16, leftPadding: 16, rightPadding: 16),
            TextHeaderWidget(
              title: product.productName,
              subTitle: "Short dress",
              trailingText: "\$${product.productPrice}",
              textStyle: AppTextStyles.font24BlackWeight400,
              function: () {},
              titleStyle: AppTextStyles.font24BlackWeight400,
              subTitleStyle: AppTextStyles.font11GrayWeight400,
            ),
            RatingWidget(product: product).horizontalPadding(16),
            5.verticalSizedBox,
            Text(
              "Short dress in soft cotton jersey with decorative buttons down the front and a wide, frill-trimmed square neckline with concealed elastication. Elasticated seam under the bust and short puff sleeves with a small frill trim.",
              style: AppTextStyles.font14BlackWeight400,
            ).horizontalPadding(16),
            10.verticalSizedBox,
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }
}
