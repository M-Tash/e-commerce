import 'package:dartz/dartz.dart';
import 'package:e_commerce/domain/entities/GetCartResponseEntity.dart';

import '../entities/failures.dart';
import '../repository/repository/cart_repository.dart';

class GetCartUseCase {
  CartRepository cartRepository;

  GetCartUseCase({required this.cartRepository});

  Future<Either<Failures, CartResponseEntity>> invoke() {
    return cartRepository.getCart();
  }
}
