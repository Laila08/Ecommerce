import 'package:ecommerceapp/core/controllers/view_mode/view_mode_cubit.dart';
import 'package:ecommerceapp/core/views/widgets/category_details_view_widgets/shimmer/category_details_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/category_details/category_details_cubit.dart';
import '../../../utils/constants.dart';
import 'empty_products_view.dart';
import 'grid_products_view.dart';
import 'list_products_view.dart';

class CategoryProductsList extends StatelessWidget {
  const CategoryProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<CategoryDetailsCubit, CategoryDetailsState>(
        builder: (context, state) {
          final products = context.read<CategoryDetailsCubit>().sortedProducts;

          return BlocBuilder<ViewModeCubit, ViewMode>(
            builder: (context, mode) {
              if (state is CategoryDetailsLoading) {
                return CategoryDetailsLoading(isGrid: mode == ViewMode.grid);
              }

              if (products.isEmpty) {
                return const EmptyProductsView();
              }

              return mode == ViewMode.list
                  ? ListProductsView(products: products)
                  : GridProductsView(products: products);
            },
          );
        },
      ),
    );
  }
}
