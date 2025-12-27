import 'package:chat_app/view/common_screens/common_screen.dart';
import 'package:chat_app/view/home/helper/bottom_nav_bar.dart';
import 'package:chat_app/view/home/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_app/view_model/home/home_controller.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final homeRead = ref.read(homeController);
    homeRead.disposeController();
  }

  List<Widget> widgetsList =[
    TabScreen(),
    CommonScreen(title:'Offers'),
    CommonScreen(title:'Settings'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /// Screens
          Expanded(
            child: Consumer(
                builder: (context,ref,child){
                  final homeWatch = ref.watch(homeController);
                  return widgetsList[homeWatch.homeSelectedIndex];
                }
            ),
          ),

          /// Bottom nav bar
          BottomNavBar(),

        ],
      ),
    );
  }

}
