import 'package:dartz/dartz.dart';
import 'package:e_commerce/domain/repository/repository/home_repository.dart';

import '../entities/CategoryOrBrandResponseEntity.dart';
import '../entities/failures.dart';

class GetAllCategoriesUseCase {
  HomeRepository homeRepository;

  GetAllCategoriesUseCase({required this.homeRepository});

  Future<Either<Failures, CategoryOrBrandResponseEntity>> invoke() {
    return homeRepository.getCategories();
  }
}
