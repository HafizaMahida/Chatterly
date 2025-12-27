import 'package:chat_app/data/repository/chat/model/chat_model.dart';
import 'package:chat_app/view/utils/const/app_enums.dart';

class UserModel {
  final String? id;
  final String? name;
  final UserPresence? presence;
  final String? lastSeen;
  final DateTime? lastChatTime;
  final List<ChatMessage>? chats;

  const UserModel({
    this.id,
    this.name,
    this.presence,
    this.lastSeen,
    this.lastChatTime,
    this.chats,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      presence: json['presence'] != null
          ? UserPresence.values[json['presence']]
          : null,
      lastSeen: json['lastSeen'],
      lastChatTime: json['lastChatTime'] != null
          ? DateTime.parse(json['lastChatTime'])
          : null,
      chats: json['chats'] != null
          ? (json['chats'] as List)
          .map((e) => ChatMessage.fromJson(e))
          .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'presence': presence?.index,
    'lastSeen': lastSeen,
    'lastChatTime': lastChatTime?.toIso8601String(),
    'chats': chats?.map((e) => e.toJson()).toList(),
  };

  String get initial =>
      (name != null && name!.isNotEmpty) ? name![0].toUpperCase() : '?';

  bool get isOnline => presence == UserPresence.online;
}

