import 'package:dartz/dartz.dart';
import 'package:e_commerce/data/api/ApiManager.dart';
import 'package:e_commerce/domain/entities/AuthResultEntity.dart';
import 'package:e_commerce/domain/entities/failures.dart';
import 'package:e_commerce/domain/repository/data_source/auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  ApiManager apiManager;

  AuthRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, AuthResultEntity>> register(String name, String email,
      String password, String rePassword, String phone) async {
    var either =
        await apiManager.register(name, email, password, rePassword, phone);
    return either.fold((failures) {
      return Left(failures);
    }, (response) {
      return Right(response.toAuthResultEntity());
    });
  }

  @override
  Future<Either<Failures, AuthResultEntity>> login(
      String email, String password) async {
    var either = await apiManager.login(email, password);
    return either.fold((l) {
      return Left(l);
    }, (response) {
      return Right(response.toAuthResultEntity());
    });
  }
}
