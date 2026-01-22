import 'package:ecommerceapp/core/controllers/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_loading_widget.dart';
import 'home_error_widget.dart';
import 'home_success_widget.dart';

class HomeBodyWidget extends StatelessWidget {
  final HomeCubit homeCubit;

  const HomeBodyWidget({super.key, required this.homeCubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: homeCubit,
      buildWhen: (previous, current) =>
          current is HomeSuccess ||
          current is HomeLoading ||
          current is HomeFailed,
      builder: (context, state) {
        if (state is HomeLoading) {
          return const HomeLoadingWidget();
        } else if (state is HomeFailed) {
          return HomeErrorWidget(error: state.error);
        } else if (state is HomeSuccess) {
          return HomeSuccessWidget(state: state);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
