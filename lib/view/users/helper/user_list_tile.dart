import 'package:chat_app/data/repository/users/user_model.dart';
import 'package:chat_app/view/utils/const/app_constants.dart';
import 'package:chat_app/view/utils/theme/app_colors.dart';
import 'package:chat_app/view/utils/theme/text_styles.dart';
import 'package:chat_app/view/utils/widgets/common_avatar_widget.dart';
import 'package:chat_app/view/utils/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserListTile extends StatelessWidget {
  final UserModel user;
  final VoidCallback? onTap;

  const UserListTile({
    super.key,
    required this.user,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: AppColors.primary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r)
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.w),
          child: Row(
            children: [
              /// Avatar
              Stack(
                children: [
                  Avatar(initial: user.initial),
                  AppConstants.constant.getPresenceFromId(user.id) == 'Online'?Positioned(
                    right: 3.w,
                      bottom: 3,
                      child: const _StatusDot(color: Colors.green)):const Offstage(),
                ],
              ),

              SizedBox(width: 12.w),

              /// Name and status dot
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      title:user.name??'-',
                      style: TextStyles.medium.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        if (AppConstants.constant.getPresenceFromId(user.id) == 'Online') ...[
                          CommonText(
                            title: 'Online',
                            style: TextStyles.regular.copyWith(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ] else ...[
                          CommonText(
                            title:'${AppConstants.constant.getPresenceFromId(user.id)} ago',
                            style: TextStyles.regular.copyWith(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Status dot
class _StatusDot extends StatelessWidget {
  final Color color;

  const _StatusDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 11.h,
      height: 11.h,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

