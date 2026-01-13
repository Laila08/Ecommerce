import 'package:ecommerceapp/core/components/widgets/arrow_back_icon.dart';
import 'package:ecommerceapp/core/controllers/category/category_cubit.dart';
import 'package:ecommerceapp/core/models/product_model.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../extensions/app_extentions.dart';
import 'widgets/categoryViewWidget/product_cat_item.dart';

class CategoryDetailsView extends StatelessWidget {
  final String catName;
  final String gender;
  final List<ProductModel> products;
  final List<String> catTypesList;

  const CategoryDetailsView({
    super.key,
    required this.catName,
    required this.gender,
    required this.products,
    required this.catTypesList,
  });

  @override
  Widget build(BuildContext context) {
    final headerHigh = 234 - context.appBarHeight;
    final categoryCubit  = context.read<CategoryCubit>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leading: ArrowBackIcon(),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: headerHigh,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: AppColors.blackColor.withValues(alpha: 0.12),
                  blurRadius: 12,
                  spreadRadius: 0,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Women’s tops",
                  style: AppTextStyles.font34BlackWeight700,
                ).onlyPadding(
                  leftPadding: 16,
                  topPadding: 16,
                  bottomPadding: 8,
                ),
                SizedBox(
                  height: 30,
                  child: BlocBuilder<CategoryCubit, CategoryState>(
                    bloc: categoryCubit,
                    builder: (context, state) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: catTypesList.length,
                        itemBuilder: (context, index) {
                          final type = catTypesList[index];
                          final isSelected = categoryCubit.selectedCatType == type;
                          return InkWell(
                            onTap: () => categoryCubit.filterByCatType(type),
                            child: Container(
                              height: 30,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: isSelected?AppColors.whiteColor:AppColors.blackColor,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected ? Colors.black : Colors.transparent,
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    type,
                                    style: isSelected?AppTextStyles.font14blackWeight500:AppTextStyles.font14WhiteWeight500,
                                  ),
                                  if (isSelected) ...[
                                    const SizedBox(width: 6),
                                    InkWell(
                                      onTap: () {
                                        categoryCubit.clearFilter();
                                      },
                                      child: Icon(
                                        Icons.close,
                                        size: 16,
                                        color: AppColors.errorColor,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ).onlyPadding(leftPadding: 16),
                          );
                        },

                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.filter_list_outlined),
                        Text(
                          'Filters',
                        ).onlyPadding(leftPadding: 7),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.swap_vert_sharp),
                        Text(
                          'Price: lowest to high',
                        ).onlyPadding(leftPadding: 7),
                      ],
                    ),
                    Icon(Icons.list),
                  ],
                )
                    .horizontalPadding(16)
                    .onlyPadding(
                  topPadding: 16,
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<CategoryCubit, CategoryState>(
              bloc: categoryCubit,
              builder: (context, state) {
                final products =
                    categoryCubit.filteredProducts ?? categoryCubit.currentProducts;
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) =>
                      ProductCatItem(product: products[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
