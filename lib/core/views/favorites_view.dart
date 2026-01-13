import 'package:ecommerceapp/core/controllers/favorite/favorite_cubit.dart';
import 'package:ecommerceapp/core/views/widgets/favorite_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/widgets/arrow_back_icon.dart';
import '../utils/app_colors.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteCubit>().clearSelectedCatType();
  }
  @override
  Widget build(BuildContext context) {
    final favoriteCubit = BlocProvider.of<FavoriteCubit>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<FavoriteCubit, FavoriteState>(
              bloc: favoriteCubit,
              buildWhen: (previous, current) =>
                  current is FavoriteLoading ||
                  current is FavoriteSuccess ||
                  current is FavoriteFailed,
              builder: (context, state) {
                if (state is FavoriteLoading) {
                  return CircularProgressIndicator().center();
                } else if (state is FavoriteFailed) {
                  return Text(state.error).center();
                } else if (state is FavoriteSuccess) {
                  final catTypes = state.catTypes;
                  final filteredProducts = state.selectedCatType == null
                      ? state.favoriteProducts
                      : state.favoriteProducts
                      .where((p) => p.catType == state.selectedCatType)
                      .toList(growable: false);

                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.blackColor.withValues(
                                      alpha: 0.12,
                                    ),
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
                                    "Favorites",
                                    style: AppTextStyles.font34BlackWeight700,
                                  ).onlyPadding(
                                    leftPadding: 16,
                                    topPadding: 16,
                                    bottomPadding: 8,
                                  ),
                                  SizedBox(
                                    height: 30,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: catTypes.length,
                                      itemBuilder: (context, index) {
                                        final type = catTypes[index];
                                        final isSelected =
                                            state.selectedCatType == type;
                                        final filteredProducts = isSelected
                                            ? state.favoriteProducts
                                            : state.favoriteProducts
                                                  .where(
                                                    (p) =>
                                                        p.catType ==
                                                        state.selectedCatType,
                                                  )
                                                  .toList(growable: false);
                                        return InkWell(
                                          onTap: () =>
                                              favoriteCubit.selectCatType(
                                                isSelected ? null : type,
                                              ),
                                          child: Container(
                                            height: 30,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: isSelected
                                                  ? AppColors.whiteColor
                                                  : AppColors.blackColor,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              border: Border.all(
                                                color: isSelected
                                                    ? Colors.black
                                                    : Colors.transparent,
                                                width: 1.5,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  type,
                                                  style: isSelected
                                                      ? AppTextStyles
                                                            .font14blackWeight500
                                                      : AppTextStyles
                                                            .font14WhiteWeight500,
                                                ),
                                                if (isSelected) ...[
                                                  const SizedBox(width: 6),
                                                  Icon(
                                                    Icons.close,
                                                    size: 16,
                                                    color:
                                                        AppColors.errorColor,
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ).onlyPadding(leftPadding: 16),
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
                                        bottomPadding: 10,
                                      ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        FavoriteListWidget(products: filteredProducts),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
