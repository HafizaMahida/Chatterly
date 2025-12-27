import 'package:chat_app/data/local/session.dart';
import 'package:chat_app/data/repository/users/user_model.dart';
import 'package:chat_app/view/utils/const/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';


final usersController = ChangeNotifierProvider((ref) => UsersController());
class UsersController extends ChangeNotifier{

  /// user name ctr
  TextEditingController userNameCtr = TextEditingController();


  /// Local storage instance
  final storage = UserLocalStorage();


  List<UserModel> userList =[];
  /// Get Added users list
  Future<void> loadUsers() async {
    userList.clear();
    userList.addAll(await storage.getUsers());
    notifyListeners();
  }

  /// Add user
  Future<void> addNewUser() async{
    final user = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: userNameCtr.text,
      presence: UserPresence.online,
      chats: [],
    );
    userList.add(user);
    storage.addUser(user);
    notifyListeners();
  }


  /// Clear add new user controller
  void clearAddUserCtr(){
    userNameCtr.clear();
  }

  /// update local list user
  void updateLocalListUser(String oldId, UserModel updatedUser ){
    final userIndex = userList.indexWhere((u) => u.id == oldId);
    userList[userIndex]= updatedUser;
    notifyListeners();
  }

}

