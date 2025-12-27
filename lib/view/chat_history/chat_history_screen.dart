import 'package:chat_app/data/repository/users/user_model.dart';
import 'package:chat_app/view/chat_history/helper/chat_history_list_tile.dart';
import 'package:chat_app/view/utils/widgets/common_empty_state_widget.dart';
import 'package:chat_app/view_model/chat_history/chat_history_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatHistoryTabScreen extends ConsumerStatefulWidget {
  const ChatHistoryTabScreen({super.key});

  @override
  ConsumerState<ChatHistoryTabScreen> createState() => _UserTabScreenState();
}

class _UserTabScreenState extends ConsumerState<ChatHistoryTabScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final chatHistoryRead = ref.watch(chatHistoryController);
    return chatHistoryRead.userChatHistoryList.isEmpty?
    Center(
      child: CommonEmptyStateWidget(
        strIcon:'assets/images/no_chats.png',
        title: 'No chat history found. Start a chat with created users!',
        imgHeight: 190.h,
        imgWidth: 190.w,
      ),
    )

    :ListView.builder(
        itemCount: chatHistoryRead.userChatHistoryList.length,
        itemBuilder: (_, i) {
          UserModel user = chatHistoryRead.userChatHistoryList[i];
          return
            Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 3.h),
            child: ChatHistoryListTile(
              user: user,
            ),
          );
        }
    );
  }
}
