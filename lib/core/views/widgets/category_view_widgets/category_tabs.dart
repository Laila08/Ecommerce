import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

import '../../../controllers/category/category_cubit.dart';
import '../../../theme/app_text_styles.dart';
import '../../../utils/app_colors.dart';
import 'category_list_widget.dart';

class CategoryTabs extends StatelessWidget {
  const CategoryTabs({super.key});

  static const List<String> _tabs = ['Women', 'Men', 'Kids'];

  @override
  Widget build(BuildContext context) {
    final categoryCubit = context.read<CategoryCubit>();

    return Container(
      color: AppColors.backGroundColor,
      width: double.infinity,
      height: double.infinity,
      child: ContainedTabBarView(
        tabBarProperties: TabBarProperties(
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 3,
          indicatorColor: AppColors.primaryColor,
          labelColor: AppColors.blackColor,
          labelStyle: AppTextStyles.font16BlackWeight400,
        ),
        tabs: const [Text('Women'), Text('Men'), Text('Kids')],
        views: _tabs.map((gender) {
          return CategoryListWidget(
            gender: gender,
            products: categoryCubit.getProductsByGender(gender),
          );
        }).toList(),
      ),
    );
  }
}
