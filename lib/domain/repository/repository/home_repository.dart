import 'package:dartz/dartz.dart';
import 'package:e_commerce/domain/entities/AddCartResponseEntity.dart';
import 'package:e_commerce/domain/entities/CategoryOrBrandResponseEntity.dart';
import 'package:e_commerce/domain/entities/ProductResponseEntity.dart';

import '../../entities/failures.dart';

abstract class HomeRepository {
  Future<Either<Failures, CategoryOrBrandResponseEntity>> getCategories();

  Future<Either<Failures, CategoryOrBrandResponseEntity>> getBrands();

  Future<Either<Failures, ProductResponseEntity>> getAllProducts();

  Future<Either<Failures, AddCartResponseEntity>> addToCart(String productId);
}
