import 'package:e_commerce/domain/entities/ProductResponseEntity.dart';

import '../../../../../domain/entities/AddCartResponseEntity.dart';
import '../../../../../domain/entities/failures.dart';

abstract class ProductListStates {}

class ProductListInitialState extends ProductListStates {}

class ProductListLoadingState extends ProductListStates {}

class ProductListErrorState extends ProductListStates {
  Failures? errors;

  ProductListErrorState({required this.errors});
}

final class ProductListSuccessState extends ProductListStates {
  ProductResponseEntity productResponseEntity;

  ProductListSuccessState({required this.productResponseEntity});
}

class AddToCartInitState extends ProductListStates {}

class AddToCartLoadingState extends ProductListStates {}

class AddToCartErrorState extends ProductListStates {
  Failures? errors;

  AddToCartErrorState({required this.errors});
}

final class AddToCartSuccessState extends ProductListStates {
  AddCartResponseEntity addCartResponseEntity;

  AddToCartSuccessState({required this.addCartResponseEntity});
}
