import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class SortCubit extends Cubit<int> {
  SortCubit() : super(-1);

  void selectSort(int index) => emit(index);

  void clearSort() => emit(-1);
}