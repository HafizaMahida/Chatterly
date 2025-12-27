import 'package:chat_app/view/utils/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_app/view/utils/theme/app_colors.dart';
import 'package:chat_app/view/utils/theme/text_styles.dart';

class CommonEmptyStateWidget extends StatelessWidget {
  final String? title;
  final String? strIcon;
  final double? imgWidth;
  final double? imgHeight;
  final TextStyle? textStyle;
  const CommonEmptyStateWidget({super.key,this.title,this.strIcon,this.imgWidth,this.imgHeight,this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          Image.asset(
            strIcon??'assets/images/empty_state.png',
            height: imgHeight??150.h,
            width: imgWidth??150.h,
          ),
          SizedBox(height: 15.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: CommonText(
              title:title??'No data found!',
              style:textStyle?? TextStyles.regular.copyWith(
                color: AppColors.black,
                fontSize: 16.sp,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
        ]
    );
  }
}
