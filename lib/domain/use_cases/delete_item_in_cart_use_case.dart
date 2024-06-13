import 'package:dartz/dartz.dart';
import 'package:e_commerce/domain/entities/GetCartResponseEntity.dart';

import '../entities/failures.dart';
import '../repository/repository/cart_repository.dart';

class DeleteItemInCartUseCase {
  CartRepository cartRepository;

  DeleteItemInCartUseCase({required this.cartRepository});

  Future<Either<Failures, CartResponseEntity>> invoke(String productId) {
    return cartRepository.deleteItemInCart(productId);
  }

  Future<Either<Failures, CartResponseEntity>> invokeALlItems() {
    return cartRepository.deleteAllItemsInCart();
  }
}
