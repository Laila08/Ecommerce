import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:ecommerceapp/core/views/widgets/favorites_view_widgets/sort_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../controllers/sort/sort_cubit.dart';

class SortSection extends StatelessWidget {
  final SortCubit sortCubit;
  const SortSection({super.key, required this.sortCubit});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: AppColors.backGroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(34)),
              ),
              builder: (context) {
                return SortBottomSheet(
                  sortCubit: sortCubit,
                  selectedIndex: sortCubit.state,
                );
              },
            );
          },
          child: Icon(Icons.swap_vert_sharp),
        ),
        SizedBox(width: 7),
        BlocBuilder<SortCubit, int>(
          bloc: sortCubit,
          builder: (context, selectedIndex) {
            String text = selectedIndex >= 0
                ? [
                    'Popular',
                    'Newest',
                    'Customer review',
                    'Price: lowest to high',
                    'Price: highest to low',
                  ][selectedIndex]
                : 'Price: lowest to high';
            return Text(text);
          },
        ),
      ],
    );
  }
}
