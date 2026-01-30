import 'package:ecommerceapp/core/controllers/sort/sort_cubit.dart';
import 'package:ecommerceapp/core/views/widgets/favorites_view_widgets/filter_section.dart';
import 'package:ecommerceapp/core/views/widgets/favorites_view_widgets/sort_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../controllers/view_mode/view_mode_cubit.dart';
import '../../../extensions/app_extentions.dart';
import '../../../utils/constants.dart';

class ProductFiltersRow extends StatelessWidget {
  final SortCubit sortCubit;
  const ProductFiltersRow({super.key, required this.sortCubit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const FilterSection(),
          SortSection(sortCubit: sortCubit),
          BlocBuilder<ViewModeCubit, ViewMode>(
            builder: (context, mode) {
              return IconButton(
                icon: Icon(
                  mode == ViewMode.list ? Icons.grid_view : Icons.list,
                ),
                onPressed: () => context.read<ViewModeCubit>().toggle(),
              );
            },
          ),
        ],
      ),
    );
  }
}
