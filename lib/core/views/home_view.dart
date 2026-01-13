import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:ecommerceapp/core/utils/products_list_type.dart';
import 'package:ecommerceapp/core/controllers/home/home_cubit.dart';
import 'package:ecommerceapp/core/views/widgets/text_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../routes/routes.dart';
import 'widgets/home_header_widget.dart';
import 'widgets/horizontal_products_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            HomeHeaderWidget(width: width),
            BlocBuilder<HomeCubit, HomeState>(
              bloc: homeCubit,
              buildWhen: (previous, current) =>
                  current is HomeSuccess ||
                  current is HomeLoading ||
                  current is HomeFailed,
              builder: (context, state) {
                if (state is HomeLoading) {
                  return CircularProgressIndicator().center().allPading(50);
                } else if (state is HomeFailed) {
                  return Text(state.error).center();
                } else if (state is HomeSuccess) {
                  final salesProducts = state.salesProducts;
                  final newProducts = state.newProducts;
                  return Column(
                    children: [
                      TextHeaderWidget(
                        subTitle: "Super summer sale",
                        title: "Sale",
                        trailingText: "View all",
                        textStyle: AppTextStyles.font11BlackWeight400,
                        function: () {
                          //context.pushNamed(Routes.category,);
                        },
                        titleStyle: AppTextStyles.font34BlackWeight700,
                        subTitleStyle: AppTextStyles.font11GrayWeight400,
                      ),
                      HorizontalProductsList(
                        color: AppColors.errorColor,
                        listType: ProductsListType.sale,
                        products: salesProducts,
                      ),
                      TextHeaderWidget(
                        subTitle: "You’ve never seen it before!",
                        title: "New",
                        trailingText: "View all",
                        textStyle: AppTextStyles.font11BlackWeight400,
                        titleStyle: AppTextStyles.font34BlackWeight700,
                        subTitleStyle: AppTextStyles.font11GrayWeight400,
                        function: () {},
                      ),
                      HorizontalProductsList(
                        color: AppColors.blackColor,
                        listType: ProductsListType.New,
                        products: newProducts,
                      ),
                      20.verticalSizedBox,
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
