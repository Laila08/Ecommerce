import 'package:flutter/material.dart';

import '../../../extensions/app_extentions.dart';
import '../../../models/delivery_method_model.dart';
import '../../../theme/app_text_styles.dart';
import '../../../utils/app_colors.dart';

class DeliveryMethodCard extends StatelessWidget {
  final DeliveryMethodModel deliveryMethod;
  final VoidCallback onTap;
  final bool isLast;

  const DeliveryMethodCard({
    super.key,
    required this.deliveryMethod,
    required this.onTap,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.only(right: isLast ? 0 : 16),
        padding: 10.allPading,
        height: 72,
        decoration: BoxDecoration(
          borderRadius: 16.allBorderRadius,
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withValues(alpha: 0.08),
              blurRadius: 25,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(deliveryMethod.imgUrl),
            Text(deliveryMethod.days, style: AppTextStyles.font11GrayWeight400),
          ],
        ),
      ),
    );
  }
}
