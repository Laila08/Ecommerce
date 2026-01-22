import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../utils/constants.dart';

class ViewModeCubit extends Cubit<ViewMode> {
  ViewModeCubit() : super(ViewMode.list);

  void toggle() {
    emit(state == ViewMode.list ? ViewMode.grid : ViewMode.list);
  }

  void setMode(ViewMode mode) {
    emit(mode);
  }
}