import 'package:chat_app/view/utils/theme/app_colors.dart';
import 'package:chat_app/view/utils/theme/text_styles.dart';
import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  final String title;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final double? fontSize;
  final Color? clrFont;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final TextStyle? style;
  final TextOverflow? overflow;

  const CommonText({super.key, this.title = '', this.fontWeight, this.fontStyle, this.fontSize, this.clrFont, this.maxLines, this.textAlign, this.textDecoration, this.style, this.overflow});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      //-- will not change if system fonts size changed
      maxLines: maxLines,
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow ?? TextOverflow.ellipsis,
      style:
      style ??
          TextStyle(
            fontFamily: TextStyles.fontFamily,
            fontWeight: fontWeight ?? TextStyles.fwRegular,
            fontSize: fontSize ?? 14,
            color: clrFont ?? AppColors.black,
            fontStyle: fontStyle ?? FontStyle.normal,
            decorationColor: clrFont ?? AppColors.black,
            decoration: textDecoration ?? TextDecoration.none,
          ),
    );
  }
}
