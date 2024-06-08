import 'package:dartz/dartz.dart';
import 'package:e_commerce/domain/entities/GetCartResponseEntity.dart';

import '../entities/failures.dart';
import '../repository/repository/cart_repository.dart';

class UpdateItemInCartUseCase {
  CartRepository cartRepository;

  UpdateItemInCartUseCase({required this.cartRepository});

  Future<Either<Failures, CartResponseEntity>> invoke(
      String productId, int count) {
    return cartRepository.updateItemInCart(productId, count);
  }
}
