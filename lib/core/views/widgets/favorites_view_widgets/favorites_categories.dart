import 'package:flutter/material.dart';

import '../../../controllers/favorite/favorite_cubit.dart';
import '../../../extensions/app_extentions.dart';
import '../../../theme/app_text_styles.dart';
import '../../../utils/app_colors.dart';

class FavoritesCategories extends StatelessWidget {
  final List<String> catTypes;
  final FavoriteSuccess state;
  final FavoriteCubit favoriteCubit;

  const FavoritesCategories({
    super.key,
    required this.catTypes,
    required this.state,
    required this.favoriteCubit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: catTypes.length,
        itemBuilder: (context, index) {
          final type = catTypes[index];
          final isSelected = state.selectedCatType == type;
          return InkWell(
            onTap: () => favoriteCubit.selectCatType(isSelected ? null : type),
            child: Container(
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.whiteColor : AppColors.blackColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? AppColors.blackColor : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    type,
                    style: isSelected
                        ? AppTextStyles.font14blackWeight500
                        : AppTextStyles.font14WhiteWeight500,
                  ),
                  if (isSelected) ...[
                    const SizedBox(width: 6),
                    Icon(Icons.close, size: 16, color: AppColors.errorColor),
                  ],
                ],
              ),
            ).onlyPadding(leftPadding: 16),
          ).onlyPadding(rightPadding: index+1 == catTypes.length?16:0);
        },
      ),
    );
  }
}
