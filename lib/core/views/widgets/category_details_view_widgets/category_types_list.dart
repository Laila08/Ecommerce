import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/category_details/category_details_cubit.dart';
import 'category_type_item.dart';

class CategoryTypesList extends StatelessWidget {
  final String gender;
  final List<String> catTypesList;

  const CategoryTypesList({
    super.key,
    required this.gender,
    required this.catTypesList,
  });

  @override
  Widget build(BuildContext context) {
    final categoryCubit = context.read<CategoryDetailsCubit>();

    return SizedBox(
      height: 30,
      child: BlocBuilder<CategoryDetailsCubit, CategoryDetailsState>(
        builder: (context, state) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: catTypesList.length,
            itemBuilder: (context, index) {
              final type = catTypesList[index];
              final isSelected = categoryCubit.selectedCatType == type;
              return CategoryTypeItem(
                type: type,
                isSelected: isSelected,
                onTap: () => categoryCubit.filterByCatType(type),
                onClear: () => categoryCubit.clearFilter(),
                isLast: index + 1 == catTypesList.length,
              );
            },
          );
        },
      ),
    );
  }
}
