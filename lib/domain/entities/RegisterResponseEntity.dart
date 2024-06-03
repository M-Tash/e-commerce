import 'UserEntity.dart';

/// message : "success"
/// user : {"name":"ahmed","email":"ahmedmutti1555@gmail.com","role":"user"}
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2MGMyM2E1YmU4YjUyMzIzNWE5M2RjNiIsIm5hbWUiOiJhaG1lZCIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzEyMDcxNTkwLCJleHAiOjE3MTk4NDc1OTB9.7Q17xoMJt6MLxJCtN0Fzardcsh4kXAzelKQW4gCDKvs"

class RegisterResponseEntity {
  RegisterResponseEntity({
    this.message,
    this.user,
    this.token,
  });

  String? message;
  UserEntity? user;
  String? token;
}
