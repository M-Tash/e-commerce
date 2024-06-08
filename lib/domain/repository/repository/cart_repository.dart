import 'package:dartz/dartz.dart';

import '../../entities/GetCartResponseEntity.dart';
import '../../entities/failures.dart';

abstract class CartRepository {
  Future<Either<Failures, CartResponseEntity>> getCart();

  Future<Either<Failures, CartResponseEntity>> deleteItemInCart(
      String productId);

  Future<Either<Failures, CartResponseEntity>> updateItemInCart(
      String productId, int count);
}
