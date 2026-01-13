import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:ecommerceapp/core/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class RatingWidget extends StatelessWidget {
  final ProductModel product;
  const RatingWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBarIndicator(
          itemSize: 13.0,
          direction: Axis.horizontal,
          itemPadding: 2.0.hPading,
          rating:product.productRate?.toDouble()??0.0 ,
          itemBuilder: (BuildContext context, int index) {
            return Icon(Icons.star,color: AppColors.starColor);
          },
        ),Text("(10)",style: AppTextStyles.font10GrayWeight400,),
      ],
    );
  }
}
