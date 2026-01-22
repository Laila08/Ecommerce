import 'package:ecommerceapp/core/controllers/view_mode/view_mode_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/category_details/category_details_cubit.dart';
import '../../../utils/constants.dart';
import '../category_view_widgets/product_cat_item.dart';
import 'product_grid_item.dart';

class CategoryProductsList extends StatelessWidget {
  const CategoryProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<CategoryDetailsCubit, CategoryDetailsState>(
        builder: (context, state) {
          final products = context.read<CategoryDetailsCubit>().sortedProducts;
          return BlocBuilder<ViewModeCubit, ViewMode>(
            builder: (context, mode) => mode == ViewMode.list
                ? ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) =>
                        ProductCatItem(product: products[index]),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: calculateChildAspectRatio(context, 260),
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) =>
                        ProductGridItem(product: products[index]),
                  ),
          );
        },
      ),
    );
  }
}
