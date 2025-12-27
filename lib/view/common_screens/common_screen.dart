import 'package:chat_app/view/utils/theme/text_styles.dart';
import 'package:chat_app/view/utils/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonScreen extends StatelessWidget {
  final String title;
  const CommonScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: CommonText(
            title: title,
            fontSize: 20.sp,
            fontWeight: TextStyles.fwMedium,
          ),
        ),
      ),
    );
  }
}
