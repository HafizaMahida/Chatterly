import 'package:chat_app/view/utils/const/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

final homeController = ChangeNotifierProvider((ref) => HomeController());
class HomeController extends ChangeNotifier{


  ///Dispose Controller
  void disposeController() {
    homeSelectedIndex = 0;
    activeTab = TabEnums.users;
  }

  /// Home screen bottom nav selected index
  int homeSelectedIndex = 0;

  /// Update bottom nav selected index
  void updateSelectedIndex(index){
    homeSelectedIndex = index;
    notifyListeners();
  }

  /// Home screen tab selected value
  TabEnums activeTab = TabEnums.users;

  /// Update tab selected value
  void updateHomeTab(TabEnums value){
    activeTab = value;
    notifyListeners();
  }

  List<Map<String,dynamic>> bottomIconsList =[
    {
      'icons':Icons.home,
      'title':'Home',
    },
    {
      'icons':Icons.local_offer_sharp,
      'title':'Offers',
    },
    {
      'icons':Icons.settings,
      'title':'Settings',
    },

  ];


}

