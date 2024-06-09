import 'package:dartz/dartz.dart';
import 'package:e_commerce/data/api/ApiManager.dart';
import 'package:e_commerce/domain/entities/AddCartResponseEntity.dart';
import 'package:e_commerce/domain/entities/CategoryOrBrandResponseEntity.dart';
import 'package:e_commerce/domain/entities/ProductResponseEntity.dart';
import 'package:e_commerce/domain/entities/failures.dart';
import 'package:e_commerce/domain/repository/data_source/home_remote_data_source.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  ApiManager apiManager;

  HomeRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, CategoryOrBrandResponseEntity>>
      getCategories() async {
    var either = await apiManager.getCategories();
    return either.fold((l) {
      return Left(l);
    }, (response) {
      return Right(response);
    });
  }

  @override
  Future<Either<Failures, CategoryOrBrandResponseEntity>> getBrands() async {
    var either = await apiManager.getBrands();
    return either.fold((l) {
      return Left(l);
    }, (response) {
      return Right(response);
    });
  }

  @override
  Future<Either<Failures, ProductResponseEntity>> getAllProducts() async {
    var either = await apiManager.getAllProducts();
    return either.fold((l) {
      return Left(l);
    }, (response) {
      return Right(response);
    });
  }

  @override
  Future<Either<Failures, AddCartResponseEntity>> addToCart(
      String productId) async {
    var either = await apiManager.addToCart(productId);
    return either.fold((l) {
      return Left(l);
    }, (response) {
      return Right(response);
    });
  }
}
