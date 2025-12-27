import 'package:chat_app/data/local/session.dart';
import 'package:chat_app/data/network/dio/api_client.dart';
import 'package:chat_app/data/repository/chat/model/chat_model.dart';
import 'package:chat_app/data/repository/chat/model/receiver_message_response_model.dart';
import 'package:chat_app/data/repository/chat/repo/chat_repository.dart';
import 'package:chat_app/data/repository/users/user_model.dart';
import 'package:chat_app/view/utils/const/app_constants.dart';
import 'package:chat_app/view/utils/const/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
final chatController = ChangeNotifierProvider((ref) => ChatController());
class ChatController extends ChangeNotifier{

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
  Future<void> sendMessage(String userId) async {
    final users = await storage.getUsers();
    final userIndex = users.indexWhere((u) => u.id == userId);
    if (userIndex == -1) return;

    final ChatMessage message = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: chatCtr.text.trim(),
      type: MessageType.sender,
      timestamp: DateTime.now(),
    );

    final user = users[userIndex];

    final updatedUser = UserModel(
      id: user.id,
      name: user.name,
      presence: user.presence,
      lastSeen: user.lastSeen,
      lastChatTime: DateTime.now(),
      chats: [...(user.chats ?? []), message],
    );

    users[userIndex] = updatedUser;
    await storage.saveUsers(users);

    userChat.add(message);
    chatCtr.clear();
    chatUser = updatedUser;
    notifyListeners();

    /// Receiver message
    await getReceiverMessage(userId);
  }

  bool isLoading = false;

  ReceiverMessageResponseModel? receiverMessageResponseModel;



  /// --------------------- Api Implementation -----------------------///
  final ChatRepository chatRepository = ChatRepository(ApiClient());

  /// User Details api
  Future<void> getReceiverMessage(String userId,) async {
    isLoading = true;
    notifyListeners();

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
    } catch (e) {
      AppConstants.constant.showLog("Receiver error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}