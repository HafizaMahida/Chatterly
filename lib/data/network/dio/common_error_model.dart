// To parse this JSON data, do
//
//     final commonErrorModel = commonErrorModelFromJson(jsonString);

import 'dart:convert';

CommonErrorModel commonErrorModelFromJson(String str) => CommonErrorModel.fromJson(json.decode(str));

String commonErrorModelToJson(CommonErrorModel data) => json.encode(data.toJson());

class CommonErrorModel {
  String? title;
  String? message;
  String? resolution;

  CommonErrorModel({
    this.title,
    this.message,
    this.resolution,
  });

  factory CommonErrorModel.fromJson(Map<String, dynamic> json) => CommonErrorModel(
    title: json["title"],
    message: json["message"],
    resolution: json["resolution"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "message": message,
    "resolution": resolution,
  };
}
