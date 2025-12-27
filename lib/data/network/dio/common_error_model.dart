class CommonErrorModel {
  String? error;
  int? statusCode;
  String? message;
  List<String>? messages;

  CommonErrorModel({
    this.message,
    this.messages,
    this.error,
    this.statusCode,
  });

  factory CommonErrorModel.fromJson(Map<String, dynamic> json) {
    final msg = json["message"];

    return CommonErrorModel(
      message: msg is String ? msg : null,
      messages: msg is List ? msg.map((e) => e.toString()).toList() : null,
      error: json["error"]?.toString(),
      statusCode: json["statusCode"],
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message ?? messages,
    "error": error,
    "statusCode": statusCode,
  };

  String get errorMessage => message ?? messages?.join(", ") ?? "";
}
