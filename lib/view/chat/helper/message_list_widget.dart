import 'package:chat_app/view/chat/helper/word_selectable_text.dart';
import 'package:chat_app/view/utils/const/app_constants.dart';
import 'package:chat_app/view/utils/const/app_enums.dart';
import 'package:chat_app/view/utils/theme/app_colors.dart';
import 'package:chat_app/view/utils/theme/text_styles.dart';
import 'package:chat_app/view/utils/widgets/common_avatar_widget.dart';
import 'package:chat_app/view/utils/widgets/common_text.dart';
import 'package:chat_app/view_model/chat/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class MessageList extends ConsumerWidget {

  final String userInitial;
  const MessageList({super.key,required this.userInitial});

  @override
  Widget build(BuildContext context,ref) {
    final chatWatch = ref.watch(chatController);
    return chatWatch.userChat.isEmpty?const Offstage():ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      reverse: true,
      itemCount: chatWatch.userChat.length + (chatWatch.isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (chatWatch.isLoading && index == 0) {
          return  Align(
            alignment: Alignment.centerLeft,
            child: LoadingAnimationWidget.waveDots(
              color: AppColors.brandYellowDark,
              size: 25,
            ),
          );

        }

        final messageIndex =
        chatWatch.isLoading ? index - 1 : index;

        final msg = chatWatch
            .userChat[chatWatch.userChat.length - 1 - messageIndex];

        return msg.type == MessageType.sender
            ? _SenderBubble(text: msg.text ?? '',time: AppConstants.constant.formatTime(msg.timestamp??DateTime.now()),initial: userInitial,)
            : _ReceiverBubble(text: msg.text ?? '',time: AppConstants.constant.formatTime(msg.timestamp??DateTime.now()),initial: userInitial,);
      },
    );
  }
}


class _SenderBubble extends StatelessWidget {
  final String text;
  final String time;
  final String initial;

  const _SenderBubble({required this.text,required this.time,required this.initial});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(bottom: 5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  constraints: const BoxConstraints(maxWidth: 260),
                  decoration: BoxDecoration(
                    color: const Color(0xffDCF8C6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      bottomLeft: Radius.circular(12.r),
                      bottomRight: Radius.circular(12.r),
                    )
                  ),
                  child:  WordSelectableText(
                    text: text,
                    style: TextStyles.regular.copyWith(color: AppColors.black),
                  ),
                ),
                CommonText(
                  title:time,
                  style: TextStyles.regular.copyWith(
                    color: AppColors.grayDark1,
                    fontSize: 12.sp
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            SizedBox(width: 5.w,),
            Avatar(initial: 'Y',color:AppColors.errorColor.withValues(alpha: 0.7)),
          ],
        ),
      ),
    );
  }
}

class _ReceiverBubble extends StatelessWidget {
  final String text;
  final String time;
  final String initial;
  const _ReceiverBubble({required this.text,required this.time,required this.initial});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Avatar(initial: initial),
        SizedBox(width: 5.w,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              constraints: const BoxConstraints(maxWidth: 260),
              decoration: BoxDecoration(
                color: AppColors.brandYellow,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12.r),
                  bottomLeft: Radius.circular(12.r),
                  bottomRight: Radius.circular(12.r),
                )
              ),
              child: WordSelectableText(
                text: text,
                style: TextStyles.regular.copyWith(color: AppColors.black),
              ),
            ),
            CommonText(
              title:time,
              style: TextStyles.regular.copyWith(
                  color: AppColors.grayDark1,
                  fontSize: 12.sp
              ),
            )
          ],
        ),
      ],
    );
  }
}