import 'package:dartz/dartz.dart';
import 'package:e_commerce/domain/entities/ProductResponseEntity.dart';
import 'package:e_commerce/domain/repository/repository/home_repository.dart';

import '../entities/failures.dart';

class GetAllProductsUseCase {
  HomeRepository homeRepository;

  GetAllProductsUseCase({required this.homeRepository});

  Future<Either<Failures, ProductResponseEntity>> invoke() {
    return homeRepository.getAllProducts();
  }
}
