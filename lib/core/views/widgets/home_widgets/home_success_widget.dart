import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:ecommerceapp/core/utils/products_list_type.dart';
import 'package:ecommerceapp/core/controllers/home/home_cubit.dart';
import 'package:ecommerceapp/core/views/widgets/home_widgets/text_header_widget.dart';
import 'package:flutter/material.dart';
import 'horizontal_products_list.dart';

class HomeSuccessWidget extends StatelessWidget {
  final HomeSuccess state;

  const HomeSuccessWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextHeaderWidget(
          subTitle: "Super summer sale",
          title: "Sale",
          trailingText: "View all",
          textStyle: AppTextStyles.font11BlackWeight400,
          titleStyle: AppTextStyles.font34BlackWeight700,
          subTitleStyle: AppTextStyles.font11GrayWeight400,
          function: () {},
        ),
        HorizontalProductsList(
          color: AppColors.errorColor,
          listType: ProductsListType.sale,
          products: state.salesProducts,
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
          products: state.newProducts,
        ),
        20.verticalSizedBox,
      ],
    );
  }
}
