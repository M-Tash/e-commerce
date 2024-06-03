import 'package:dartz/dartz.dart';
import 'package:e_commerce/domain/repository/repository/auth_repository.dart';

import '../entities/AuthResultEntity.dart';
import '../entities/failures.dart';

class LoginUseCase {
  AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  Future<Either<Failures, AuthResultEntity>> invoke(
      String email, String password) {
    return authRepository.login(email, password);
  }
}
