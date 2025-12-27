import 'package:chat_app/view/chat/chat_screen.dart';
import 'package:chat_app/view/chat_history/chat_history_screen.dart';
import 'package:chat_app/view/home/helper/appbar_switcher.dart';
import 'package:chat_app/view/users/helper/add_user_widget.dart';
import 'package:chat_app/view/users/user_tab_screen.dart';
import 'package:chat_app/view/utils/const/app_enums.dart';
import 'package:chat_app/view/utils/theme/app_colors.dart';
import 'package:chat_app/view_model/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabScreen extends StatelessWidget {
  const TabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Consumer(
        builder: (context,ref,_) {
          final homeWatch = ref.watch(homeController);
          return homeWatch.activeTab == TabEnums.users? FloatingActionButton(
            onPressed: () => showAddUserBottomSheet(context),
            child: const Icon(Icons.add),
            backgroundColor: AppColors.brandYellowDark,
          ): const Offstage();
        }
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final homeWatch = ref.watch(homeController);
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                snap: true,
                centerTitle: true,
                title: const AppbarSwitcher(),
              ),

              SliverFillRemaining(
                child: IndexedStack(
                  index: homeWatch.activeTab == TabEnums.users ? 0 : 1,
                  children: const [
                    UserTabScreen(),
                    ChatHistoryTabScreen()
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

