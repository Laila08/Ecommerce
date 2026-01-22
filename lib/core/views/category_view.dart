import 'package:ecommerceapp/core/views/widgets/category_view_widgets/category_app_bar.dart';
import 'package:ecommerceapp/core/views/widgets/category_view_widgets/category_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/widgets/app_dialog.dart';
import '../controllers/category/category_cubit.dart';
import '../controllers/home/home_cubit.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();

    return Scaffold(
      appBar: CategoryAppBar(),
      body: BlocBuilder<HomeCubit, HomeState>(
        bloc: homeCubit,
        buildWhen: (previous, current) =>
            current is HomeSuccess ||
            current is HomeFailed ||
            current is HomeLoading,
        builder: (context, state) {
          if (state is HomeLoading) {
            return const CircularProgressIndicator();
          }
          if (state is HomeFailed) {
            return AppDialog(message: state.error);
          }
          if (state is HomeSuccess) {
            return BlocProvider(
              create: (_) => CategoryCubit(
                men: state.menProducts,
                women: state.womenProducts,
                kids: state.kidsProducts,
              ),
              child: const CategoryTabs(),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
