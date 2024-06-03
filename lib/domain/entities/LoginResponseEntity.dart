import 'package:e_commerce/domain/entities/UserEntity.dart';

/// message : "success"
/// user : {"name":"ahmed","email":"ahmedmutti1555@gmail.com","role":"user"}
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2MGMyM2E1YmU4YjUyMzIzNWE5M2RjNiIsIm5hbWUiOiJhaG1lZCIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzEyMzI5MDY4LCJleHAiOjE3MjAxMDUwNjh9.IM8xFdLnMUXwYDws_WnTqjN6UKMsgoGyuNjJcrCdeP0"

class LoginResponseEntity {
  LoginResponseEntity({
    this.message,
    this.user,
    this.token,
  });

  String? message;
  UserEntity? user;
  String? token;
}
