import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_app/view/utils/theme/app_colors.dart';
import 'package:chat_app/view/utils/theme/text_styles.dart';

class CommonFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final double? borderRadius;

  const CommonFormField({
    super.key,
    required this.controller,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.onFieldSubmitted,
    this.maxLength,
    this.borderRadius
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: TextStyles.medium.copyWith(
        color:AppColors.black,
        fontSize: 12.sp
      ),
      cursorColor: AppColors.brandYellowDark,
      textInputAction: textInputAction,
      maxLength: maxLength,
      buildCounter: (
          context, {
            required int currentLength,
            required int? maxLength,
            required bool isFocused,
          }) {
        return null;
      },
    decoration: InputDecoration(

        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: TextStyles.regular.copyWith(
            color:AppColors.grayLight1,
            fontSize: 12.sp
        ),
        errorMaxLines: 10,
        filled: true,
        fillColor:AppColors.primary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius??8),
          borderSide: BorderSide(
              color: AppColors.grayLight1,width: 1,
              style: BorderStyle.solid),
        ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius??8),
        borderSide: BorderSide(
            color: AppColors.grayLight1,width: 1,
            style: BorderStyle.solid),
      ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius??8),
          borderSide: BorderSide(
              color: AppColors.brandYellowDark,width: 1,
              style: BorderStyle.solid),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 14.h,horizontal: 17.w),
      ),
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
