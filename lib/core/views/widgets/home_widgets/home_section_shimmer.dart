import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/extensions/app_extentions.dart';
import '../../../theme/app_text_styles.dart';
import 'product_shimmer_item.dart';
import 'text_header_widget.dart';
import '../../../../core/utils/app_messages.dart';

class HomeSectionShimmer extends StatelessWidget {
  final String title;
  final String subTitle;

  const HomeSectionShimmer({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    final height = context.heigh;

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      period: const Duration(milliseconds: 1000),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextHeaderWidget(
            title: title,
            subTitle: subTitle,
            trailingText: AppMessages.viewAll,
            textStyle: AppTextStyles.font11BlackWeight400,
            titleStyle: AppTextStyles.font34BlackWeight700,
            subTitleStyle: AppTextStyles.font11GrayWeight400,
            function: () {},
          ),
          12.verticalSizedBox,
          SizedBox(
            height: height * 0.36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (_, _) =>
                  const ProductShimmerItem().onlyPadding(rightPadding: 16),
              separatorBuilder: (_, _) => 0.horizontalSizedBox,
            ),
          ),
        ],
      ),
    );
  }
}
