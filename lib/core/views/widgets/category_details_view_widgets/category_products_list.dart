import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controllers/category_details/category_details_cubit.dart';
import '../category_view_widgets/product_cat_item.dart';

class CategoryProductsList extends StatelessWidget {
  const CategoryProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryCubit = context.read<CategoryDetailsCubit>();

    return Expanded(
      child: BlocBuilder<CategoryDetailsCubit, CategoryDetailsState>(
        builder: (context, state) {
          final displayedProducts =
              categoryCubit.filteredProducts ?? categoryCubit.currentProducts;
          return ListView.builder(
            itemCount: displayedProducts.length,
            itemBuilder: (context, index) =>
                ProductCatItem(product: displayedProducts[index]),
          );
        },
      ),
    );
  }
}
