import 'package:ecommerceapp/core/controllers/firestore_controller.dart';
import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:ecommerceapp/core/utils/products_list_type.dart';
import 'package:ecommerceapp/features/auth/presentation/views/widgets/text_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/home_header_widget.dart';
import 'widgets/horizontal_products_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            HomeHeaderWidget(width: width),
            TextHeaderWidget(
              subTitle: "Super summer sale",
              title: "Sale",
              trailingText: "View all",
              textStyle: AppTextStyles.font11BlackWeight400,
              function: () {},
              titleStyle:  AppTextStyles.font34WhiteWeight700,
              subTitleStyle: AppTextStyles.font11GrayWeight400,
            ),
            HorizontalProductsList(
              color: AppColors.errorColor,
              listType: ProductsListType.sale,
              productsStreamtype: Provider.of<DataBase>(
                context,
              ).salesProductsStream(),
            ),
            TextHeaderWidget(
              subTitle: "You’ve never seen it before!",
              title: "New",
              trailingText: "View all",
              textStyle: AppTextStyles.font11BlackWeight400,
              titleStyle:  AppTextStyles.font34WhiteWeight700,
              subTitleStyle: AppTextStyles.font11GrayWeight400,
              function: () {},
            ),
            HorizontalProductsList(
              color: AppColors.blackColor,
              listType: ProductsListType.newProducts,
              productsStreamtype: Provider.of<DataBase>(
                context,
              ).productsStream(),
            ),
            20.verticalSizedBox,
          ],
        ),
      ),
    );
  }
}
