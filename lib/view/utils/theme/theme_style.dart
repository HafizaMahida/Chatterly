import 'package:flutter/material.dart';
import 'package:chat_app/view/utils/theme/app_colors.dart';
import 'package:chat_app/view/utils/theme/text_styles.dart';

class ThemeStyle {
  static ThemeData themeData(BuildContext context) {

    return ThemeData(
      fontFamily: TextStyles.fontFamily,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.black,
        surface: AppColors.black,
        error: AppColors.errorColor,
      ),
      textTheme: Theme.of(context).textTheme.apply(
        bodyColor:  AppColors.black,
        displayColor:  AppColors.black,
      ),
      scaffoldBackgroundColor:  AppColors.scaffoldBG,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: AppColors.lightGray1,
        ),
        hintStyle: TextStyle(
          color: AppColors.lightGray1.withOpacity(0.6),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color:AppColors.brandYellowDark),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.brandYellowDark),
        ),
      ),
      appBarTheme: AppBarTheme(
        color: AppColors.scaffoldBG
      ),
      splashColor: AppColors.transparent,//To disable ripple effect
      hoverColor: AppColors.transparent,
      highlightColor: AppColors.transparent,//To disable ripple effect
    );

  }
}