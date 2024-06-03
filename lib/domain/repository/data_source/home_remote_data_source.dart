import 'package:dartz/dartz.dart';

import '../../entities/CategoryOrBrandResponseEntity.dart';
import '../../entities/failures.dart';

abstract class HomeRemoteDataSource {
  Future<Either<Failures, CategoryOrBrandResponseEntity>> getCategories();

  Future<Either<Failures, CategoryOrBrandResponseEntity>> getBrands();
}
