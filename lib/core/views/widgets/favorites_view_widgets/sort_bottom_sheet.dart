import 'package:ecommerceapp/core/utils/app_constants.dart';
import 'package:flutter/material.dart';

import '../../../controllers/sort/sort_cubit.dart';
import '../../../extensions/app_extentions.dart';
import '../../../theme/app_text_styles.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_messages.dart';

class SortBottomSheet extends StatelessWidget {
  final SortCubit sortCubit;
  final int selectedIndex;

  const SortBottomSheet({
    super.key,
    required this.sortCubit,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Container(
            width: 60,
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.grayColor,
              borderRadius: 3.allBorderRadius,
            ),
          ),
        ).onlyPadding(topPadding: 20, bottomPadding: 20),
        Align(
          alignment: Alignment.center,
          child: Text(
            AppMessages.sortBy,
            style: AppTextStyles.font18BlackWeight400,
          ),
        ).onlyPadding(bottomPadding: 20),
        ...List.generate(
          AppConstants.sortOptions.length,
          (index) => InkWell(
            onTap: () {
              sortCubit.selectSort(index);
              Navigator.pop(context);
            },
            child: Container(
              width: double.infinity,
              height: 48,
              color: selectedIndex == index
                  ? AppColors.primaryColor
                  : Colors.transparent,
              child: Text(
                AppConstants.sortOptions[index],
                style: selectedIndex == index
                    ? AppTextStyles.font16WhiteWeight400
                    : AppTextStyles.font16BlackWeight400,
              ).horizontalPadding(16).verticalPadding(14),
            ),
          ),
        ),
        10.verticalSizedBox,
      ],
    );
  }
}
