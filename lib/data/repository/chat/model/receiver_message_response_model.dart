// To parse this JSON data, do
//
//     final receiverMessageResponseModel = receiverMessageResponseModelFromJson(jsonString);

import 'dart:convert';

ReceiverMessageResponseModel receiverMessageResponseModelFromJson(String str) => ReceiverMessageResponseModel.fromJson(json.decode(str));

String receiverMessageResponseModelToJson(ReceiverMessageResponseModel data) => json.encode(data.toJson());

class ReceiverMessageResponseModel {
  List<Comment>? comments;
  int? total;
  int? skip;
  int? limit;

  ReceiverMessageResponseModel({
    this.comments,
    this.total,
    this.skip,
    this.limit,
  });

  factory ReceiverMessageResponseModel.fromJson(Map<String, dynamic> json) => ReceiverMessageResponseModel(
    comments: json["comments"] == null ? [] : List<Comment>.from(json["comments"]!.map((x) => Comment.fromJson(x))),
    total: json["total"],
    skip: json["skip"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "comments": comments == null ? [] : List<dynamic>.from(comments!.map((x) => x.toJson())),
    "total": total,
    "skip": skip,
    "limit": limit,
  };
}

class Comment {
  int? id;
  String? body;
  int? postId;
  int? likes;
  User? user;

  Comment({
    this.id,
    this.body,
    this.postId,
    this.likes,
    this.user,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
    body: json["body"],
    postId: json["postId"],
    likes: json["likes"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "body": body,
    "postId": postId,
    "likes": likes,
    "user": user?.toJson(),
  };
}

class User {
  int? id;
  String? username;
  String? fullName;

  User({
    this.id,
    this.username,
    this.fullName,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    fullName: json["fullName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "fullName": fullName,
  };
}
