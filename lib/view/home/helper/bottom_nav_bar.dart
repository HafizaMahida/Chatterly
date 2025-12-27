import 'package:chat_app/view/utils/theme/app_colors.dart';
import 'package:chat_app/view/utils/theme/text_styles.dart';
import 'package:chat_app/view/utils/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_app/view_model/home/home_controller.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final homeWatch = ref.watch(homeController);
    return Consumer(
        builder: (context,ref,child){
          return Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical:11.h,horizontal: 30.w),
              child: Card(
                color: AppColors.scaffoldBG,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r)
                ),
                elevation: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ...List.generate(3, (index){
                        return InkWell(
                          onTap: (){
                            ref.read(homeController).updateSelectedIndex(index);
                          },
                          child: Column(
                            children: [
                              Icon(
                                homeWatch.bottomIconsList[index]['icons'],
                                size: 25.h,
                                color: homeWatch.homeSelectedIndex == index?AppColors.brandYellowDark:AppColors.iconGray,
                              ),
                              CommonText(
                                title:homeWatch.bottomIconsList[index]['title'] ,
                                style: TextStyles.regular.copyWith(
                                  fontSize: 11.sp,
                                  color: homeWatch.homeSelectedIndex == index?AppColors.brandYellowDark:AppColors.iconGray,
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}
