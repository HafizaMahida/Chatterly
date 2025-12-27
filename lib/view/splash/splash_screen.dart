import 'package:chat_app/view/home/home_screen.dart';
import 'package:chat_app/view/utils/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_app/view/utils/const/app_constants.dart';
import 'package:chat_app/view/utils/theme/app_colors.dart';
import 'package:chat_app/view/utils/theme/text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () async {
      if(context.mounted){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>HomeScreen()));
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                'assets/images/splash_img.png',
                height: 120.h,
                width:120.h
            ),
            CommonText(
              title:AppConstants.appName,
              style: TextStyles.medium.copyWith(
                color: AppColors.black,
              fontSize: 18.sp,
            ),
            )
          ],
        ),
      ),
    );
  }
}
