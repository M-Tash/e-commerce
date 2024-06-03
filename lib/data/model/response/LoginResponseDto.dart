import 'package:e_commerce/data/model/response/UserDto.dart';
import 'package:e_commerce/domain/entities/AuthResultEntity.dart';

/// message : "success"
/// user : {"name":"ahmed","email":"ahmedmutti1555@gmail.com","role":"user"}
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2MGMyM2E1YmU4YjUyMzIzNWE5M2RjNiIsIm5hbWUiOiJhaG1lZCIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzEyMzI5MDY4LCJleHAiOjE3MjAxMDUwNjh9.IM8xFdLnMUXwYDws_WnTqjN6UKMsgoGyuNjJcrCdeP0"

class LoginResponseDto {
  LoginResponseDto({
    this.message,
    this.user,
    this.token,
  });

  LoginResponseDto.fromJson(dynamic json) {
    message = json['message'];
    user = json['user'] != null ? UserDto.fromJson(json['user']) : null;
    token = json['token'];
    statusMsg = json['statusMsg'];
  }

  String? message;
  UserDto? user;
  String? token;
  String? statusMsg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['statusMsg'] = statusMsg;
    map['token'] = token;
    return map;
  }

  AuthResultEntity toAuthResultEntity() {
    return AuthResultEntity(userEntity: user?.toUserEntity(), token: token);
  }
}
