import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../controllers/sort/sort_cubit.dart';
import '../../../utils/constants.dart';

class SortSection extends StatelessWidget {
  final SortCubit sortCubit;
  const SortSection({
    super.key,
    required this.sortCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () =>
              showMyBottomSheet(context: context, sortCubit: sortCubit),
          child: Icon(Icons.swap_vert_sharp),
        ),
        SizedBox(width: 7),
        BlocBuilder<SortCubit, int>(
          bloc: sortCubit,
          builder: (context, selectedIndex) {
            String text = selectedIndex >= 0
                ? ['Popular','Newest','Customer review','Price: lowest to high','Price: highest to low'][selectedIndex]
                : 'Price: lowest to high';
            return Text(text);
          },
        ),
      ],
    );
  }
}

void showMyBottomSheet({
  required BuildContext context,
  required SortCubit sortCubit,
}) {
  showModalBottomSheet(
    enableDrag: true,
    requestFocus: true,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
    ),
    backgroundColor: AppColors.backGroundColor,
    builder: (context) {
      return BlocBuilder<SortCubit, int>(
        bloc: sortCubit,
        builder: (context, selectedIndex) {
          return Column(
            //spacing: 20,
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
              ).onlyPadding(topPadding: 20,bottomPadding: 20),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Sort by',
                  style: AppTextStyles.font18BlackWeight400,
                ),
              ).onlyPadding(bottomPadding: 20),
              ...List.generate(
                sortOptions.length,
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
                      sortOptions[index],
                      style: selectedIndex == index ?AppTextStyles.font16WhiteWeight400:AppTextStyles.font16BlackWeight400,
                    ).horizontalPadding(16).verticalPadding(14),
                  ),
                ),
              ),
              10.verticalSizedBox
            ],
          );
        },
      );
    },
  );
}
