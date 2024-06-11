import 'UserEntity.dart';

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
