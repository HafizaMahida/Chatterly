import 'package:chat_app/view/utils/const/app_enums.dart';

class ChatMessage {
  final String? id;
  final String? text;
  final MessageType? type;
  final DateTime? timestamp;

  const ChatMessage({
    this.id,
    this.text,
    this.type,
    this.timestamp,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      text: json['text'],
      type: json['type'] != null
          ? MessageType.values[json['type']]
          : null,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'type': type?.index,
    'timestamp': timestamp?.toIso8601String(),
  };
}
