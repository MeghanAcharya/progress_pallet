import 'dart:convert';

ServerException serverExceptionFromJson(String str) =>
    ServerException.fromJson(json.decode(str));

String serverExceptionToJson(ServerException data) =>
    json.encode(data.toJson());

class ServerException {
  int? code;
  String? message;

  ServerException({
    this.code,
    this.message,
  });

  factory ServerException.fromJson(Map<String, dynamic> json) =>
      ServerException(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}
