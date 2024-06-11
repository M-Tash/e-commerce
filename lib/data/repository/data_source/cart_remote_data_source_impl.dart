import 'package:dartz/dartz.dart';

import '../../../domain/entities/GetCartResponseEntity.dart';
import '../../../domain/entities/failures.dart';
import '../../../domain/repository/data_source/cart_remote_data_source.dart';
import '../../api/ApiManager.dart';

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  ApiManager apiManager;

  CartRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, CartResponseEntity>> getCart() async {
    var either = await apiManager.getCart();
    return either.fold((l) {
      return Left(l);
    }, (response) {
      return Right(response);
    });
  }

  @override
  Future<Either<Failures, CartResponseEntity>> deleteItemInCart(
      String productId) async {
    var either = await apiManager.deleteItemInCart(productId);
    return either.fold((l) {
      return Left(l);
    }, (response) {
      return Right(response);
    });
  }

  @override
  Future<Either<Failures, CartResponseEntity>> updateItemInCart(
      String productId, int count) async {
    var either = await apiManager.updateItemCount(productId, count);
    return either.fold((l) {
      return Left(l);
    }, (response) {
      return Right(response);
    });
  }

  @override
  Future<String?> checkOutItemsInCart(int amount) async {
    var response = await apiManager.createPayMobPayment(amount);
    return response;
  }
}
