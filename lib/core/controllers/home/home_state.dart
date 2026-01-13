part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<ProductModel> salesProducts;
  final List<ProductModel> newProducts;
  final List<ProductModel> menProducts;
  final List<ProductModel> womenProducts;
  final List<ProductModel> kidsProducts;
  final List<ProductModel> newKidsProduct;
  final List<ProductModel> newWomenProduct;
  final List<ProductModel> newMenProduct;


  HomeSuccess({
    required this.salesProducts,
    required this.newProducts,
    required this.menProducts,
    required this.womenProducts,
    required this.kidsProducts, required this.newKidsProduct, required this.newWomenProduct, required this.newMenProduct,
  });
}

final class HomeFailed extends HomeState {
  final String error;
  HomeFailed(this.error);
}
final class FilteredSuccess extends HomeState {}