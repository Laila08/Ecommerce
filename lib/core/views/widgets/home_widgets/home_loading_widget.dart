import 'package:flutter/material.dart';

import '../../../../core/extensions/app_extentions.dart';
import 'home_section_shimmer.dart';
import '../../../../core/utils/app_messages.dart';

class HomeLoadingWidget extends StatelessWidget {
  const HomeLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.verticalSizedBox,
          const HomeSectionShimmer(
            title: AppMessages.sale,
            subTitle: AppMessages.saleSubTitle,
          ),
          10.verticalSizedBox,
          const HomeSectionShimmer(
            title: AppMessages.newArrival,
            subTitle: AppMessages.newSubTitle,
          ),
          20.verticalSizedBox,
        ],
      ),
    );
  }
}
