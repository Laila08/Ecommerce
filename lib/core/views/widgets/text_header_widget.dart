import 'package:flutter/material.dart';

import '../../../../../core/extensions/app_extentions.dart';
class TextHeaderWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String trailingText;
  final TextStyle titleStyle;
  final TextStyle textStyle;
  final TextStyle subTitleStyle;
  final GestureTapCallback? function;
  const TextHeaderWidget({super.key, required this.title, required this.subTitle, required this.trailingText, required this.textStyle, required this.function, required this.titleStyle, required this.subTitleStyle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,style:titleStyle ,),
            Text(subTitle,style: subTitleStyle)
          ],
        ),
        Spacer(),
        InkWell(
          onTap:function ,
            child: Text(trailingText,style: textStyle,),)
      ],
    ).onlyPadding(rightPadding: 16,leftPadding: 16,topPadding: 16);
  }
}
