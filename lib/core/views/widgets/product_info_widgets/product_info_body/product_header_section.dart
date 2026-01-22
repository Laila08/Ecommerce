import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';
import '../../../../theme/app_text_styles.dart';
import '../../home_widgets/text_header_widget.dart';

class ProductHeaderSection extends StatelessWidget {
  final ProductModel product;

  const ProductHeaderSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return TextHeaderWidget(
      title: product.productName,
      subTitle: "Short dress",
      trailingText: "\$${product.productPrice}",
      titleStyle: AppTextStyles.font24BlackWeight400,
      subTitleStyle: AppTextStyles.font11GrayWeight400,
      textStyle: AppTextStyles.font24BlackWeight400,
      function: () {},
    );
  }
}
