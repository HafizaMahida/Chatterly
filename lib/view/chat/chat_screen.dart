import 'package:chat_app/data/repository/users/user_model.dart';
import 'package:chat_app/view/chat/helper/message_input_widget.dart';
import 'package:chat_app/view/chat/helper/message_list_widget.dart';
import 'package:chat_app/view/utils/const/app_constants.dart';
import 'package:chat_app/view/utils/theme/app_colors.dart';
import 'package:chat_app/view/utils/theme/text_styles.dart';
import 'package:chat_app/view/utils/widgets/common_text.dart';
import 'package:chat_app/view_model/chat/chat_controller.dart';
import 'package:chat_app/view_model/users/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final UserModel user;

  const ChatScreen({super.key, required this.user});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(chatController).disposeController();
    SchedulerBinding.instance.addPostFrameCallback((callback)async{
      await ref.read(chatController).addChatToList(widget.user.id??'');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _ChatAppBar(ref:ref),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/chat_bg.png'), // your generated bg
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(child: MessageList()),
            MessageInput(userId:widget.user.id??''),
          ],
        ),
      ),
    );
  }
}


/// Chat screen app bar
class _ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final WidgetRef ref;

  const _ChatAppBar({required this.ref});

  @override
  Widget build(BuildContext context) {
    final chatWatch  = ref.watch(chatController);
    return AppBar(
      leadingWidth: 32,
      titleSpacing: 0,
      leading: InkWell(
          onTap: (){
            Navigator.of(context).pop();
            ref.read(usersController).loadUsers();
          },
          child: Icon(Icons.arrow_back_sharp,color: AppColors.black,)
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.brandYellowDark,
            child: CommonText(title:chatWatch.chatUser?.initial??''),
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                title:chatWatch.chatUser?.name ?? '',
              ),
              CommonText(
                title:AppConstants.constant.getPresenceFromId(chatWatch.chatUser?.id) == 'Online'?'Online':'${AppConstants.constant.getPresenceFromId(chatWatch.chatUser?.id)} ago',
                style: TextStyles.regular.copyWith(
                    fontSize: 11.sp,
                  color: AppColors.grayLight1,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: const [
        Icon(Icons.videocam,color: AppColors.black,),
        SizedBox(width: 16,),
        Icon(Icons.call,color: AppColors.black,),
        SizedBox(width: 8),
        Icon(Icons.more_vert,color: AppColors.black,),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}






