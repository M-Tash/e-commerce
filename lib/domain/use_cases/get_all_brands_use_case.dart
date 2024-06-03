import 'package:dartz/dartz.dart';
import 'package:e_commerce/domain/repository/repository/home_repository.dart';

import '../entities/CategoryOrBrandResponseEntity.dart';
import '../entities/failures.dart';

class GetAllBrandsUseCase {
  HomeRepository homeRepository;

  GetAllBrandsUseCase({required this.homeRepository});

  Future<Either<Failures, CategoryOrBrandResponseEntity>> invoke() {
    return homeRepository.getBrands();
  }
}
