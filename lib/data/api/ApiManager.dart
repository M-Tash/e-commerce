import 'package:dartz/dartz.dart';
import 'package:e_commerce/data/api/ApiConstants.dart';
import 'package:e_commerce/data/api/ApiHelper.dart';
import 'package:e_commerce/data/model/request/LoginRequest.dart';
import 'package:e_commerce/data/model/request/RegisterRequest.dart';
import 'package:e_commerce/data/model/response/AddCartResponseDto.dart';
import 'package:e_commerce/data/model/response/CategoryOrBrandResponseDto.dart';
import 'package:e_commerce/data/model/response/GetCartResponseDto.dart';
import 'package:e_commerce/data/model/response/LoginResponseDto.dart';
import 'package:e_commerce/data/model/response/ProductResponseDto.dart';
import 'package:e_commerce/data/model/response/RegisterResponseDto.dart';
import 'package:e_commerce/domain/entities/failures.dart';
import 'package:e_commerce/ui/utils/shared_preference.dart';

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
        url: url,
        body: registerRequest.toJson(),
        errorMessage: 'Failed to register. Please try again.');
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
        url: url,
        body: loginRequest.toJson(),
        errorMessage: 'Failed to register. Please try again.');
    return result.fold(
      (failure) => Left(failure),
      (jsonResponse) => Right(LoginResponseDto.fromJson(jsonResponse)),
    );
  }

  Future<Either<Failures, CategoryOrBrandResponseDto>> getCategories() async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiEndPoints.categoryApi);
    var result = await apiHelper.get(
        url: url,
        errorMessage: 'Failed to fetch categories. Please try again.');
    return result.fold(
      (failure) => Left(failure),
      (jsonResponse) =>
          Right(CategoryOrBrandResponseDto.fromJson(jsonResponse)),
    );
  }

  Future<Either<Failures, CategoryOrBrandResponseDto>> getBrands() async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiEndPoints.brandApi);
    var result = await apiHelper.get(
        url: url, errorMessage: 'Failed to fetch brands. Please try again.');
    return result.fold(
      (failure) => Left(failure),
      (jsonResponse) =>
          Right(CategoryOrBrandResponseDto.fromJson(jsonResponse)),
    );
  }

  Future<Either<Failures, ProductResponseDto>> getAllProducts() async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiEndPoints.productsApi);
    var result = await apiHelper.get(
        url: url, errorMessage: 'Failed to fetch Products. Please try again.');
    return result.fold(
      (failure) => Left(failure),
      (jsonResponse) => Right(
        ProductResponseDto.fromJson(jsonResponse),
      ),
    );
  }

  Future<Either<Failures, AddCartResponseDto>> addToCart(
      String productId) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiEndPoints.cartApi);
    var token = SharedPreference.getData(key: 'Token');
    dynamic body = {'productId': productId};
    dynamic headers = {'token': token.toString()};
    var result = await apiHelper.post(
        url: url,
        errorMessage: 'Failed to add items. Please try again.',
        body: body,
        headers: headers);
    return result.fold(
      (failure) => Left(failure),
      (jsonResponse) => Right(
        AddCartResponseDto.fromJson(jsonResponse),
      ),
    );
  }

  Future<Either<Failures, AddCartResponseDto>> addToWishList(
      String productId) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiEndPoints.wishListApi);
    var token = SharedPreference.getData(key: 'Token');
    dynamic body = {'productId': productId};
    dynamic headers = {'token': token.toString()};
    var result = await apiHelper.post(
        url: url,
        errorMessage: 'Failed to add items. Please try again.',
        body: body,
        headers: headers);
    return result.fold(
      (failure) => Left(failure),
      (jsonResponse) => Right(
        AddCartResponseDto.fromJson(jsonResponse),
      ),
    );
  }

  Future<Either<Failures, GetCartResponseDto>> getCart() async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiEndPoints.cartApi);
    var token = SharedPreference.getData(key: 'Token');
    dynamic headers = {'token': token.toString()};
    var result = await apiHelper.get(
        url: url,
        errorMessage: 'Failed to fetch Products. Please try again.',
        headers: headers);
    return result.fold(
      (failure) => Left(failure),
      (jsonResponse) => Right(
        GetCartResponseDto.fromJson(jsonResponse),
      ),
    );
  }

  Future<Either<Failures, GetCartResponseDto>> deleteItemInCart(
      String productId) async {
    Uri url =
        Uri.https(ApiConstants.baseUrl, '${ApiEndPoints.cartApi}/$productId');
    var token = SharedPreference.getData(key: 'Token');
    dynamic headers = {'token': token.toString()};
    var result = await apiHelper.delete(
        url: url,
        errorMessage: 'Failed to fetch Products. Please try again.',
        headers: headers);
    return result.fold(
      (failure) => Left(failure),
      (jsonResponse) => Right(
        GetCartResponseDto.fromJson(jsonResponse),
      ),
    );
  }

  Future<Either<Failures, GetCartResponseDto>> updateItemCount(
      String productId, int count) async {
    Uri url =
        Uri.https(ApiConstants.baseUrl, '${ApiEndPoints.cartApi}/$productId');
    var token = SharedPreference.getData(key: 'Token');
    dynamic headers = {'token': token.toString()};
    dynamic body = {'count': count.toString()};
    var result = await apiHelper.put(
        url: url,
        errorMessage: 'Failed to fetch Products. Please try again.',
        headers: headers,
        body: body);
    return result.fold(
      (failure) => Left(failure),
      (jsonResponse) => Right(
        GetCartResponseDto.fromJson(jsonResponse),
      ),
    );
  }
}
