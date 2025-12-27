import 'package:chat_app/view/utils/theme/app_colors.dart';
import 'package:chat_app/view/utils/theme/text_styles.dart';
import 'package:chat_app/view/utils/widgets/common_text.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String initial;
  final Color? color;
  const Avatar({super.key, required this.initial,this.color});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor:color?? AppColors.brandYellow,
      child: CommonText(
        title:  initial,
        style: TextStyles.regular.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}