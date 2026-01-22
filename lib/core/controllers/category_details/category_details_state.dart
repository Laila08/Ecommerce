part of 'category_details_cubit.dart';

@immutable
sealed class CategoryDetailsState {}

final class CategoryInitial extends CategoryDetailsState {}
final class CategoryLoaded extends CategoryDetailsState {}
final class CategoryFiltered extends CategoryDetailsState {}
final class CategorySorted extends CategoryDetailsState {}