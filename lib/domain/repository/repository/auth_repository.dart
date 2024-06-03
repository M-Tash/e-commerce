import 'package:dartz/dartz.dart';
import 'package:e_commerce/domain/entities/AuthResultEntity.dart';
import 'package:e_commerce/domain/entities/failures.dart';

abstract class AuthRepository {
  Future<Either<Failures, AuthResultEntity>> register(String name, String email,
      String password, String rePassword, String phone);

  Future<Either<Failures, AuthResultEntity>> login(
      String email, String password);
}
