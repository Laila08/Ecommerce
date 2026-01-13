import 'package:ecommerceapp/core/controllers/cart/cart_cubit.dart';
import 'package:ecommerceapp/core/views/widgets/cart_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BagView extends StatelessWidget {
  const BagView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCubit = BlocProvider.of<CartCubit>(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.search, color: Colors.black, size: 25),
            ),
            Text("My Bag", style: AppTextStyles.font34BlackWeight700),
            BlocBuilder<CartCubit, CartState>(
              bloc: cartCubit,
              buildWhen: (previous, current) =>
                  current is CartILoading ||
                  current is CartISuccess ||
                  current is CartIFailed ||
                  current is CartILoading,
              builder: (context, state) {
                if (state is CartILoading) {
                  return CircularProgressIndicator().center();
                } else if (state is CartIFailed) {
                  return Text(state.error).center();
                } else if (state is CartISuccess) {
                  final cartProducts = state.cartProducts;
                  final totalPrice = state.totalPrice;
                  return CartListWidget(products: cartProducts ,totalPrice:totalPrice);
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            20.verticalSizedBox,
          ],
        ).allPading(16),
      ),
    );
  }
}
