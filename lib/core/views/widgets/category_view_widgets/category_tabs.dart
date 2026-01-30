import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/category/category_cubit.dart';
import '../../../theme/app_text_styles.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';
import 'category_tab_view.dart';

class CategoryTabs extends StatelessWidget {
  const CategoryTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryCubit = context.read<CategoryCubit>();
    return ContainedTabBarView(
      tabBarProperties: _tabBarProperties,
      tabs: AppConstants.categoryTabs.map((gender) => Text(gender)).toList(),
      views: AppConstants.categoryTabs
          .map(
            (gender) =>
                CategoryTabView(gender: gender, categoryCubit: categoryCubit),
          )
          .toList(),
    );
  }

  TabBarProperties get _tabBarProperties => const TabBarProperties(
    indicatorSize: TabBarIndicatorSize.tab,
    indicatorWeight: 3,
    indicatorColor: AppColors.primaryColor,
    labelColor: AppColors.blackColor,
    labelStyle: AppTextStyles.font16BlackWeight400,
  );
}
