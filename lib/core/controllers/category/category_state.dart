part of 'category_cubit.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}
final class CategoryLoaded extends CategoryState {}
final class CategoryFiltered extends CategoryState {}