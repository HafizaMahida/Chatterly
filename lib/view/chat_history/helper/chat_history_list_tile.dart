import 'package:chat_app/data/repository/users/user_model.dart';
import 'package:chat_app/view/utils/const/app_constants.dart';
import 'package:chat_app/view/utils/theme/app_colors.dart';
import 'package:chat_app/view/utils/theme/text_styles.dart';
import 'package:chat_app/view/utils/widgets/common_avatar_widget.dart';
import 'package:chat_app/view/utils/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatHistoryListTile extends StatelessWidget {
  final UserModel user;
  const ChatHistoryListTile( {super.key,required this.user,});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primary,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r)
      ),
      child:Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.w),
        child: Row(
          children: [
            Avatar(initial: user.initial),
            SizedBox(width: 12.w),

            /// Name + last message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    title:user.name ?? '',
                    style: TextStyles.medium.copyWith(
                      fontSize: 14.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  CommonText(
                    title:user.chats?.lastOrNull?.text ?? '',
                    style: TextStyles.regular.copyWith(
                      fontSize: 13.sp,
                      color: AppColors.grayLight1,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            SizedBox(width: 8.w),

            /// Time + unread badge
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CommonText(
                  title:AppConstants.constant.formatChatTime(user.lastChatTime) ?? '',
                  style: TextStyles.regular.copyWith(
                    fontSize: 11.sp,
                    color: Colors.grey.shade500,
                  ),
                ),
                 SizedBox(height: 6.w),
                if ((/*item.unreadCount ?? 0*/3) > 0)
                  _UnreadBadge(count: 3),
              ],
            ),
          ],
        ),
      )
    );
  }
}

class _UnreadBadge extends StatelessWidget {
  final int count;

  const _UnreadBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: const BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      child: Text(
        count.toString(),
        style: const TextStyle(
          fontSize: 11,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}


