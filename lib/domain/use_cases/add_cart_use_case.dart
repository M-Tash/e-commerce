import 'package:dartz/dartz.dart';

import '../entities/AddCartResponseEntity.dart';
import '../entities/failures.dart';
import '../repository/repository/home_repository.dart';

class AddToCartUseCase {
  HomeRepository homeRepository;

  AddToCartUseCase({required this.homeRepository});

  Future<Either<Failures, AddCartResponseEntity>> invoke(
      {required String productId}) {
    return homeRepository.addToCart(productId);
  }
}
