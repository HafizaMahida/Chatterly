import 'package:chat_app/data/repository/users/user_model.dart';
import 'package:chat_app/view/chat/chat_screen.dart';
import 'package:chat_app/view/users/helper/user_list_tile.dart';
import 'package:chat_app/view/utils/widgets/common_empty_state_widget.dart';
import 'package:chat_app/view_model/users/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserTabScreen extends ConsumerStatefulWidget {
  const UserTabScreen({super.key});

  @override
  ConsumerState<UserTabScreen> createState() => _UserTabScreenState();
}

class _UserTabScreenState extends ConsumerState<UserTabScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((callback)async{
      await ref.read(usersController).loadUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final userWatch = ref.watch(usersController);
    return
    /// Empty State
      userWatch.userList.isEmpty?
          CommonEmptyStateWidget(strIcon:'assets/images/no_user_found.png',title: 'No users found. Create an user to start chat!',):

          /// Users list
      ListView.builder(
      itemCount: userWatch.userList.length,
      itemBuilder: (_, i) {
        UserModel user = userWatch.userList[i];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 3.h),
          child: UserListTile(
            user: user,
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ChatScreen(user: user)));
            },
          ),
        );
      }
    );
  }
}
