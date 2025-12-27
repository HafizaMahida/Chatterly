import 'package:chat_app/view/home/helper/tab_item_widget.dart';
import 'package:chat_app/view/utils/const/app_enums.dart';
import 'package:chat_app/view_model/chat_history/chat_history_controller.dart';
import 'package:chat_app/view_model/home/home_controller.dart';
import 'package:chat_app/view_model/users/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppbarSwitcher extends ConsumerWidget {
  const AppbarSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeWatch = ref.watch(homeController);
    return Container(
      height: 36,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabItem(
              label: 'Users',
              isActive: homeWatch.activeTab == TabEnums.users,
              onTap: () {
                homeWatch.updateHomeTab(TabEnums.users);
                ref.read(usersController).loadUsers();
              }
          ),
          TabItem(
              label: 'Chat History',
              isActive: homeWatch.activeTab == TabEnums.chat,
              onTap: () async{
                homeWatch.updateHomeTab(TabEnums.chat);
                ref.read(chatHistoryController).loadChatHistory();
              }
          ),
        ],
      ),
    );
  }
}

