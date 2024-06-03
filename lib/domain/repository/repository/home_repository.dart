import 'package:dartz/dartz.dart';
import 'package:e_commerce/domain/entities/CategoryOrBrandResponseEntity.dart';

import '../../entities/failures.dart';

abstract class HomeRepository {
  Future<Either<Failures, CategoryOrBrandResponseEntity>> getCategories();

  Future<Either<Failures, CategoryOrBrandResponseEntity>> getBrands();
}
