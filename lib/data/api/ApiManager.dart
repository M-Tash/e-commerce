import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/data/api/ApiConstants.dart';
import 'package:e_commerce/data/api/ApiHelper.dart';
import 'package:e_commerce/data/model/request/LoginRequest.dart';
import 'package:e_commerce/data/model/request/RegisterRequest.dart';
import 'package:e_commerce/data/model/response/CategoryOrBrandResponseDto.dart';
import 'package:e_commerce/data/model/response/LoginResponseDto.dart';
import 'package:e_commerce/data/model/response/ProductResponseDto.dart';
import 'package:e_commerce/data/model/response/RegisterResponseDto.dart';
import 'package:e_commerce/domain/entities/failures.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  ApiManager._();

  static ApiManager? _instance;

  static ApiManager getInstance() {
    _instance ??= ApiManager._();
    return _instance!;
  }

  ApiHelper apiHelper = ApiHelper.getInstance();

  Future<Either<Failures, RegisterResponseDto>> register(String name,
      String email, String password, String rePassword, String phone) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiEndPoints.registerApi);
    var registerRequest = RegisterRequest(
        name: name,
        email: email,
        password: password,
        phone: phone,
        rePassword: rePassword);
    var result = await apiHelper.post(
        url, registerRequest.toJson(), 'Failed to register. Please try again.');
    return result.fold(
      (failure) => Left(failure),
      (jsonResponse) => Right(RegisterResponseDto.fromJson(jsonResponse)),
    );
  }

  Future<Either<Failures, LoginResponseDto>> login(
      String email, String password) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiEndPoints.loginApi);
    var loginRequest = LoginRequest(
      email: email,
      password: password,
    );
    var result = await apiHelper.post(
        url, loginRequest.toJson(), 'Failed to login. Please try again.');
    return result.fold(
      (failure) => Left(failure),
      (jsonResponse) => Right(LoginResponseDto.fromJson(jsonResponse)),
    );
  }

  Future<Either<Failures, CategoryOrBrandResponseDto>> getCategories() async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiEndPoints.categoryApi);
    var result = await apiHelper.get(
        url, 'Failed to fetch categories. Please try again.');
    return result.fold(
      (failure) => Left(failure),
      (jsonResponse) =>
          Right(CategoryOrBrandResponseDto.fromJson(jsonResponse)),
    );
  }

  Future<Either<Failures, CategoryOrBrandResponseDto>> getBrands() async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiEndPoints.brandApi);
    var result =
        await apiHelper.get(url, 'Failed to fetch brands. Please try again.');
    return result.fold(
      (failure) => Left(failure),
      (jsonResponse) =>
          Right(CategoryOrBrandResponseDto.fromJson(jsonResponse)),
    );
  }

  // Future<Either<Failures, ProductResponseDto>> getAllProducts() async {
  //   Uri url = Uri.https(ApiConstants.baseUrl, ApiEndPoints.productsApi);
  //   var result = await apiHelper.get(url, 'Failed to fetch Products. Please try again.');
  //   return result.fold(
  //         (failure) => Left(failure),
  //         (jsonResponse) => Right(ProductResponseDto.fromJson(jsonResponse),),
  //
  //   );
  //
  // }

  Future<Either<Failures, ProductResponseDto>> getAllProducts() async {
    var connectivityResult =
        await Connectivity().checkConnectivity(); // User defined class
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      Uri url = Uri.https(ApiConstants.baseUrl, ApiEndPoints.productsApi);

      var response = await http.get(url);
      var productResponse =
          ProductResponseDto.fromJson(jsonDecode(response.body));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('hello');
        return Right(productResponse);
      } else {
        return Left(ServerError(errorMessage: productResponse.message));
      }
    } else {
      // no internet
      return Left(
          NetworkError(errorMessage: 'Please check internet connection '));
    }
  }
}
