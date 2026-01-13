import 'package:ecommerceapp/core/components/widgets/arrow_back_icon.dart';
import 'package:ecommerceapp/core/extensions/app_extentions.dart';
import 'package:ecommerceapp/core/theme/app_text_styles.dart';
import 'package:ecommerceapp/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ArrowBackIcon(),
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        title: Text("Checkout", style: AppTextStyles.font18BlackWeight400),
      ),
      backgroundColor: AppColors.backGroundColor,
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shipping address',
                style: AppTextStyles.font16BlackWeight400,
              ).onlyPadding(bottomPadding: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: 16.allBorderRadius,
                  color: AppColors.whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blackColor.withValues(alpha: 0.08),
                      offset: Offset(0, 1),
                      spreadRadius: 0,
                      blurRadius: 25
                    )
                  ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Jane Doe"),
                        Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Change",
                            style: AppTextStyles.font14PrimaryWeight500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "3 Newbridge Court \nChino Hills, CA 91709, United States",
                    ).onlyPadding(bottomPadding: 10)
                  ],
                ),
              ),
            ],
          ).onlyPadding(bottomPadding:16 ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Payment',
                        style: AppTextStyles.font16BlackWeight400,
                      ).onlyPadding(bottomPadding: 16),
                      Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Change",
                          style: AppTextStyles.font14PrimaryWeight500,
                        ),
                      ),
                    ],
                  ),
                  Row(children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: 16.allBorderRadius
                      ),
                        child: Image.asset("assets/images/mastercard.png",fit: BoxFit.cover,))

                  ],)
                ],
              ),
            ],
          ),
        ],
      ).allPading(16),
    );
  }
}
