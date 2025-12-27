import 'package:chat_app/data/local/session.dart';
import 'package:chat_app/data/repository/users/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';


final chatHistoryController = ChangeNotifierProvider((ref) => ChatHistoryController());
class ChatHistoryController extends ChangeNotifier{

  final storage = UserLocalStorage();

  List<UserModel> userChatHistoryList =[];
  /// Get Added users list with chat history only
  Future<void> loadChatHistory() async {
    final users = await storage.getUsers();
    userChatHistoryList
      ..clear()
      ..addAll(
        users.where(
              (u) => u.chats != null && (u.chats?.isNotEmpty??false),
        ),
      );
   notifyListeners();
  }

}

