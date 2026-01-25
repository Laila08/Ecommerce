import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/widgets/favorite_icon_widget.dart';
import '../../../../controllers/favorite/favorite_cubit.dart';
import '../../../../controllers/product_details/product_details_cubit.dart';
import '../../../../extensions/app_extentions.dart';
import '../../../../models/product_model.dart';
import '../drop_down_widget.dart';

class ProductOptionsRow extends StatelessWidget {
  final ProductModel product;

  const ProductOptionsRow({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final productDetailsCubit = context.read<ProductDetailsCubit>();
    final favoriteCubit = context.read<FavoriteCubit>();

    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 60,
            child: DropDownWidget(
              hint: "Size",
              items: ['XS', 'S', 'M', 'L', 'XL'],
              onChanged: (value) => productDetailsCubit.setSize(value!),
            ),
          ),
        ),
        16.horizontalSizedBox,
        Expanded(
          child: SizedBox(
            height: 60,
            child: DropDownWidget(
              hint: "Color",
              items: ['Black', 'Red', 'Gray', 'White'],
              onChanged: (value) => productDetailsCubit.setColor(value!),
            ),
          ),
        ),
        16.horizontalSizedBox,
        BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {
            final isFav =
                state is FavoriteSuccess &&
                state.favoriteProducts.any(
                  (p) => p.productId == product.productId,
                );
            return FavoriteIconWidget(
              isFavorite: isFav,
              onTap: () => favoriteCubit.toggleFavorite(product),
            );
          },
        ),
      ],
    ).onlyPadding(topPadding: 16, leftPadding: 16, rightPadding: 16);
  }
}
