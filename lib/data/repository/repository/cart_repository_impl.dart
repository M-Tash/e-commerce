import 'package:dartz/dartz.dart';

import '../../../domain/entities/GetCartResponseEntity.dart';
import '../../../domain/entities/failures.dart';
import '../../../domain/repository/data_source/cart_remote_data_source.dart';
import '../../../domain/repository/repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, CartResponseEntity>> getCart() {
    return remoteDataSource.getCart();
  }

  @override
  Future<Either<Failures, CartResponseEntity>> deleteItemInCart(
      String productId) {
    return remoteDataSource.deleteItemInCart(productId);
  }

  @override
  Future<Either<Failures, CartResponseEntity>> updateItemInCart(
      String productId, int count) {
    return remoteDataSource.updateItemInCart(productId, count);
  }
}
