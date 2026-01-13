import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:ecommerceapp/core/components/widgets/app_dialog.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:ecommerceapp/core/views/widgets/categoryViewWidget/category_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/home/home_cubit.dart';

class CategoryView extends StatelessWidget {

  const CategoryView({super.key, });

  @override
  Widget build(BuildContext context) {
    final homecubit = context.read<HomeCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        bloc:homecubit,
        buildWhen: (previous, current) =>
            current is HomeSuccess ||
            current is HomeFailed ||
            current is HomeLoading,
        builder: (context, state) {
          if (state is HomeLoading) {
            return Text("no data");
          } else if (state is HomeFailed) {
            return AppDialog(message: state.error);
          } else if (state is HomeSuccess) {
            final menProducts = state.menProducts;
            final womenProducts = state.womenProducts;
            final kidsProducts = state.kidsProducts;
            return Container(
              color: AppColors.backGroundColor,
              width: double.infinity,
              height: double.infinity,
              child: ContainedTabBarView(
                tabs: [Text('Women'), Text('Men'), Text('Kids')],
                views: [
                  CategoryListWidget(gender: "Women", products: menProducts),
                  CategoryListWidget(gender: "Men", products: womenProducts,),
                  CategoryListWidget(gender: "Kids", products: kidsProducts,),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
