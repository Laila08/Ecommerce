part of 'favorite_cubit.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}
final class FavoriteLoading extends FavoriteState {}

final class FavoriteSuccess extends FavoriteState {
  final List<ProductModel> favoriteProducts;
  final List<String> catTypes;
  final String? selectedCatType;
  FavoriteSuccess({required this.favoriteProducts, required this.catTypes, required this.selectedCatType,});
}
final class FavoriteFailed extends FavoriteState {
  final String error;
  FavoriteFailed(this.error);
}