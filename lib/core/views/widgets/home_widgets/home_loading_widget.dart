import 'package:ecommerceapp/core/views/widgets/home_widgets/text_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/extensions/app_extentions.dart';
import '../../../theme/app_text_styles.dart';

class HomeLoadingWidget extends StatelessWidget {
  const HomeLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = context.heigh;

    // عنصر المنتج الفردي
    Widget productShimmer() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 148,
            height: 184,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          8.verticalSizedBox,
          Container(
            height: 12,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          4.verticalSizedBox,
          Container(
            height: 12,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      );
    }

    // القسم الكامل: عنوان + قائمة أفقية
    Widget sectionShimmer(String title) {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        period: const Duration(milliseconds: 1000),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // عنوان وهمي
            TextHeaderWidget(
              subTitle: title=="Sale"?"Super summer sale": "You’ve never seen it before!",
              title:title,
              trailingText: "View all",
              textStyle: AppTextStyles.font11BlackWeight400,
              titleStyle: AppTextStyles.font34BlackWeight700,
              subTitleStyle: AppTextStyles.font11GrayWeight400,
              function: () {},
            ),
            12.verticalSizedBox,
            // قائمة المنتجات الأفقية وهمية
            SizedBox(
              height: height * 0.36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) => productShimmer().onlyPadding(rightPadding: 16),
                separatorBuilder: (_, __) => 0.horizontalSizedBox,
                itemCount: 5,
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.verticalSizedBox,
          sectionShimmer("Sale"), // قسم Sale
          10.verticalSizedBox,
          sectionShimmer("New"), // قسم New
          20.verticalSizedBox,
        ],
      ),
    );
  }
}
