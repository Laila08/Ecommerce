import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../components/widgets/favorite_icon_widget.dart';
import '../../../../controllers/favorite/favorite_cubit.dart';
import '../../../../models/product_model.dart';

class ProductFavoriteButton extends StatelessWidget {
  final ProductModel product;

  const ProductFavoriteButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final favoriteCubit = context.read<FavoriteCubit>();

    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        final isFavorite = (state is FavoriteSuccess)
            ? state.favoriteProducts.any(
                (p) => p.productId == product.productId,
              )
            : false;

        return FavoriteIconWidget(
          isFavorite: isFavorite,
          onTap: () => favoriteCubit.toggleFavorite(product),
        );
      },
    );
  }
}
