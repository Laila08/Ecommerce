import 'package:ecommerceapp/core/controllers/category_details/category_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/widgets/title_header_widget.dart';
import '../../../utils/app_colors.dart';
import '../favorites_view_widgets/favorites_filters_row.dart';
import 'category_types_list.dart';

class CategoryHeader extends StatelessWidget {
  final String catName;
  final String gender;
  final List<String> catTypesList;

  const CategoryHeader({
    super.key,
    required this.catName,
    required this.gender,
    required this.catTypesList,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CategoryDetailsCubit>();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleHeaderWidget(title: catName),
          if (catTypesList.isNotEmpty)
            CategoryTypesList(gender: gender, catTypesList: catTypesList),
          ProductFiltersRow(sortCubit: cubit.sortCubit),
        ],
      ),
    );
  }
}
