// ignore_for_file: must_be_immutable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:rozenfiled_task/core/resources/color_manager.dart';
import 'package:rozenfiled_task/core/resources/font_manager.dart';
import 'package:rozenfiled_task/core/resources/scale_factor.dart';

class CustomText extends StatelessWidget {
  final double fontSize;
  final FontWeight fontWeight;
  final String title;
  final Color color;
  TextAlign textAlign ;
  CustomText({Key? key, this.fontSize = 15, this.textAlign = TextAlign.start  , this.fontWeight = FontWeight.normal, required this.title, this.color = ColorManager.black }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      title,
      textAlign: textAlign,
      overflow: TextOverflow.clip,
      minFontSize: fontSize - 5,
      maxLines: fontSize.toInt() + 5,
      textScaleFactor: ScaleSize.textScaleFactor(context),
      style: TextStyle(
        fontFamily: FontManager.cairo,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
