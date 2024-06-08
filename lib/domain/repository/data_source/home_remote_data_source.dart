import 'package:dartz/dartz.dart';

import '../../entities/AddCartResponseEntity.dart';
import '../../entities/CategoryOrBrandResponseEntity.dart';
import '../../entities/ProductResponseEntity.dart';
import '../../entities/failures.dart';

abstract class HomeRemoteDataSource {
  Future<Either<Failures, CategoryOrBrandResponseEntity>> getCategories();

  Future<Either<Failures, CategoryOrBrandResponseEntity>> getBrands();

  Future<Either<Failures, ProductResponseEntity>> getAllProducts();

  Future<Either<Failures, AddCartResponseEntity>> addToCart(String productId);

  Future<Either<Failures, AddCartResponseEntity>> addToWishList(
      String productId);
}
