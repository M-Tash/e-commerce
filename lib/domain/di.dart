import 'package:e_commerce/data/api/ApiManager.dart';
import 'package:e_commerce/data/repository/data_source/auth_remote_data_source_impl.dart';
import 'package:e_commerce/data/repository/data_source/home_remote_data_source_impl.dart';
import 'package:e_commerce/data/repository/repository/auth_repository_impl.dart';
import 'package:e_commerce/data/repository/repository/home_repository_impl.dart';
import 'package:e_commerce/domain/repository/data_source/auth_remote_data_source.dart';
import 'package:e_commerce/domain/repository/data_source/home_remote_data_source.dart';
import 'package:e_commerce/domain/repository/repository/auth_repository.dart';
import 'package:e_commerce/domain/repository/repository/home_repository.dart';
import 'package:e_commerce/domain/use_cases/get_all_brands_use_case.dart';
import 'package:e_commerce/domain/use_cases/get_all_categories_use_case.dart';
import 'package:e_commerce/domain/use_cases/get_all_products_use_case.dart';
import 'package:e_commerce/domain/use_cases/login_use_case.dart';
import 'package:e_commerce/domain/use_cases/register_use_case.dart';

RegisterUseCase injectRegisterUseCase() {
  return RegisterUseCase(authRepository: injectAuthRepository());
}

LoginUseCase injectLoginUseCase() {
  return LoginUseCase(authRepository: injectAuthRepository());
}

GetAllCategoriesUseCase injectGetAllCategoriesUseCase() {
  return GetAllCategoriesUseCase(homeRepository: injectHomeRepository());
}

GetAllBrandsUseCase injectGetAllBrandsUseCase() {
  return GetAllBrandsUseCase(homeRepository: injectHomeRepository());
}

GetAllProductsUseCase injectGetAllProductsUseCase() {
  return GetAllProductsUseCase(homeRepository: injectHomeRepository());
}

HomeRepository injectHomeRepository() {
  return HomeRepositoryImpl(remoteDataSource: injectHomeRemoteDataSource());
}

HomeRemoteDataSource injectHomeRemoteDataSource() {
  return HomeRemoteDataSourceImpl(apiManager: ApiManager.getInstance());
}

AuthRepository injectAuthRepository() {
  return AuthRepositoryImpl(remoteDataSource: injectAuthRemoteDataSource());
}

AuthRemoteDataSource injectAuthRemoteDataSource() {
  return AuthRemoteDataSourceImpl(apiManager: ApiManager.getInstance());
}
