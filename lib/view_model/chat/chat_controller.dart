import 'dart:math';

import 'package:chat_app/data/local/session.dart';
import 'package:chat_app/data/network/dio/api_client.dart';
import 'package:chat_app/data/repository/chat/model/chat_model.dart';
import 'package:chat_app/data/repository/chat/model/receiver_message_response_model.dart';
import 'package:chat_app/data/repository/chat/model/search_meaning_response_model.dart';
import 'package:chat_app/data/repository/chat/repo/chat_repository.dart';
import 'package:chat_app/data/repository/users/user_model.dart';
import 'package:chat_app/view/utils/const/app_constants.dart';
import 'package:chat_app/view/utils/const/app_enums.dart';
import 'package:chat_app/view_model/users/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
final chatController = ChangeNotifierProvider((ref) => ChatController());
class ChatController extends ChangeNotifier{

  void disposeController(){
    chatCtr.clear();
    userChat = [];
    chatUser = null;
    isLoading = false;
  }

  final storage = UserLocalStorage();

  TextEditingController chatCtr = TextEditingController();


  List<ChatMessage> userChat =[];
  UserModel? chatUser;
  /// Get Added users list with chat history only
  Future<void>  addChatToList(String userId) async {
    userChat.clear();
    final users = await storage.getUsers();
    final userIndex = users.indexWhere((u) => u.id == userId);
    if (userIndex == -1) return;
    final user = users[userIndex];
    userChat.addAll(user.chats??[]);
    chatUser = users[userIndex];
    notifyListeners();
  }

  /// Send message
  Future<void> sendMessage(WidgetRef ref) async {

    /// Get user list from local
    final users = await storage.getUsers();

    /// Find user index
    final userIndex = users.indexWhere((u) => u.id == chatUser?.id);
    if (userIndex == -1) return;

    /// Message object
    final ChatMessage message = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: chatCtr.text.trim(),
      type: MessageType.sender,
      timestamp: DateTime.now(),
    );

    /// Get user
    final user = users[userIndex];

    /// Update user object
    final updatedUser = UserModel(
      id: user.id,
      name: user.name,
      presence: user.presence,
      lastSeen: user.lastSeen,
      lastChatTime: DateTime.now(),
      chats: [...(user.chats ?? []), message],
    );


    /// add to updated user to list
    users[userIndex] = updatedUser;

    /// save user local storage
    await storage.saveUsers(users);

    /// add message to local list
    userChat.add(message);

    /// Clear chat ctr
    chatCtr.clear();

    /// update chat user object locally
    chatUser = updatedUser;
    notifyListeners();


    /// Receiver message
    await getReceiverMessage(chatUser?.id??'',ref);
    

  }

  bool isLoading = false;
  bool isSearchLoading = false;

  ReceiverMessageResponseModel? receiverMessageResponseModel;
  List<SearchMeaningResponseModel>? listSearchMeaningResponseModel;
  SearchMeaningResponseModel? searchMeaningResponseModel;



  /// --------------------- Api Implementation -----------------------///
  final ChatRepository chatRepository = ChatRepository(ApiClient());

  /// Receive message api
  Future<void> getReceiverMessage(String userId,WidgetRef ref) async {
    isLoading = true;
    notifyListeners();
    Future.delayed(Duration(seconds: Random().nextInt(4)));


    try {
      final response = await chatRepository.getReceiverMessageApi();
      if (response == null) return;

      if (response.comments?.isEmpty ?? true) return;

      final ChatMessage message = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: response.comments!.first.body,
        type: MessageType.receiver,
        timestamp: DateTime.now(),
      );

      final users = await storage.getUsers();
      final userIndex = users.indexWhere((u) => u.id == userId);
      if (userIndex == -1) return;

      final user = users[userIndex];

      final List<ChatMessage> updatedChats = [
        ...(user.chats ?? []),
        message,
      ];

      final updatedUser = UserModel(
        id:  DateTime.now().millisecondsSinceEpoch.toString(),
        name: user.name,
        presence: user.presence,
        lastSeen: user.lastSeen,
        lastChatTime: DateTime.now(),
        chats: updatedChats,
      );

      users[userIndex] = updatedUser;
      chatUser = updatedUser;

      await storage.saveUsers(users);

      userChat.add(message);
      ref.read(usersController).updateLocalListUser(user.id??'', updatedUser);
    } catch (e) {
      AppConstants.constant.showLog("Receiver error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  /// Search word meaning api
  Future<void> searchWordMeaningApi(String word,) async {
    listSearchMeaningResponseModel = [];
    searchMeaningResponseModel = null;
    isSearchLoading = true;
    notifyListeners();

    try {
      final List<SearchMeaningResponseModel> response = await chatRepository.searchWordMeaningApi(word);

      if (response.isEmpty) {
        searchMeaningResponseModel = SearchMeaningResponseModel(
          word: word,
          isFound: false,
        );
        print("response");
        return;
      }
      searchMeaningResponseModel = response.first;
      isSearchLoading = false;
      notifyListeners();
    } on FormatException catch (e) {
      AppConstants.constant.showLog('Dictionary: ${e.message}');
    }  catch (e) {
      searchMeaningResponseModel = SearchMeaningResponseModel(
        word: word,
        isFound: false,
      );
    } finally {
      isSearchLoading = false;
      notifyListeners();
    }
  }

}

